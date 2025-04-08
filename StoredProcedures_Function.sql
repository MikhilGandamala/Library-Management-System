--Create the Fine Calculation Function
DELIMITER //
CREATE FUNCTION CalculateFine(ReturnDate DATE, DueDate DATE)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE FineAmount DECIMAL(10,2);
    DECLARE OverdueDays INT;
    
    -- Calculate overdue days
    SET OverdueDays = DATEDIFF(ReturnDate, DueDate);
    
    -- Apply fine of $1 per day if overdue
    IF OverdueDays > 0 THEN
        SET FineAmount = OverdueDays * 1.00;
    ELSE
        SET FineAmount = 0.00;
    END IF;
    
    RETURN FineAmount;
END //
DELIMITER ;

--Create the BorrowBook Procedure

DELIMITER //
CREATE PROCEDURE BorrowBook(
    IN p_MemberID INT,
    IN p_BookID INT,
    IN p_LibrarianID INT
)
BEGIN
    DECLARE v_DueDate DATE;
    DECLARE v_BookExists INT;
    DECLARE v_BookIssued INT;

    -- Check if the book exists
    SELECT COUNT(*) INTO v_BookExists FROM Book WHERE BookID = p_BookID;
    IF v_BookExists = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Book does not exist!';
    END IF;

    -- Check if the book is already issued and not returned
    SELECT COUNT(*) INTO v_BookIssued 
    FROM IssueDetail 
    WHERE BookID = p_BookID AND ReturnDate IS NULL;
    
    IF v_BookIssued > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Book is already issued and not returned!';
    END IF;

    -- Set due date (30 days from issue date)
    SET v_DueDate = DATE_ADD(CURDATE(), INTERVAL 30 DAY);

    -- Insert into Issue Table
    INSERT INTO Issue (MemberID, LibrarianID, IssueDate, DueDate) 
    VALUES (p_MemberID, p_LibrarianID, CURDATE(), v_DueDate);

    -- Insert into IssueDetail Table
    INSERT INTO IssueDetail (IssueID, BookID, ReturnDate, Fine) 
    VALUES (LAST_INSERT_ID(), p_BookID, NULL, 0);

    SELECT 'Success: Book borrowed successfully!' AS Message;
END //
DELIMITER ;


--Create the ReturnBook Procedure
DELIMITER //
CREATE PROCEDURE ReturnBook(
    IN p_BookID INT
)
BEGIN
    DECLARE v_IssueID INT;
    DECLARE v_DueDate DATE;
    DECLARE v_FineAmount DECIMAL(10,2);
    
    -- Check if the book is issued
    SELECT IssueID, DueDate INTO v_IssueID, v_DueDate 
    FROM Issue 
    WHERE IssueID = (SELECT IssueID FROM IssueDetail WHERE BookID = p_BookID AND ReturnDate IS NULL)
    LIMIT 1;
    
    IF v_IssueID IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Book is not issued or already returned!';
    END IF;

    -- Calculate fine using function
    SET v_FineAmount = CalculateFine(CURDATE(), v_DueDate);

    -- Update IssueDetail with return date and fine
    UPDATE IssueDetail 
    SET ReturnDate = CURDATE(), Fine = v_FineAmount 
    WHERE BookID = p_BookID AND IssueID = v_IssueID;

    -- If fine is applicable, insert into Fine Table
    IF v_FineAmount > 0 THEN
        INSERT INTO Fine (IssueDetailID, Amount, PaidDate, Status) 
        VALUES ((SELECT IssueDetailID FROM IssueDetail WHERE BookID = p_BookID AND IssueID = v_IssueID), v_FineAmount, NULL, 'Pending');
    END IF;

    SELECT CONCAT('Success: Book returned. Fine applied: $', v_FineAmount) AS Message;
END //
DELIMITER ;

