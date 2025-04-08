
--Positive Test Cases
-- Borrow a book (Assuming Member 1 borrows Book 1 with Librarian 1)
CALL BorrowBook(1, 1, 1);

-- Return the book within due date (No Fine)
CALL ReturnBook(1);

--Negative Test Cases
-- Borrow a non-existing book (Book ID 999 does not exist)
CALL BorrowBook(1, 999, 1);

-- Borrow an already issued book (Should fail if Book 1 is already issued)
CALL BorrowBook(2, 1, 1);

-- Return a book that was never borrowed (Book ID 999)
CALL ReturnBook(999);

-- Return a book late (Fine should be applied)
UPDATE Issue SET DueDate = DATE_SUB(CURDATE(), INTERVAL 5 DAY) WHERE IssueID = 1;
CALL ReturnBook(1);



