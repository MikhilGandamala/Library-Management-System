USE LibraryManagement1;

-- Insert Data into Library Table
INSERT INTO Library (LibraryName, Address, ContactNumber) VALUES
('Central Library', '123 Main St, City A', '123-456-7890'),
('Downtown Library', '456 Elm St, City B', '987-654-3210');

-- Insert Data into Publisher Table
INSERT INTO Publisher (PublisherName, Address, ContactNumber) VALUES
('Penguin Random House', 'New York, USA', '111-222-3333'),
('HarperCollins', 'London, UK', '444-555-6666');

-- Insert Data into Book Table
INSERT INTO Book (Title, ISBN, PublisherID, Edition, Genre, PublishedYear, Pages) VALUES
('The Great Gatsby', '978-0743273565', 1, '1st', 'Fiction', 1925, 180),
('To Kill a Mockingbird', '978-0061120084', 2, '1st', 'Fiction', 1960, 281);

-- Insert Data into LibraryBranch Table
INSERT INTO LibraryBranch (BranchName, Address, ContactNumber, LibraryID) VALUES
('Central Branch', '123 Main St, City A', '123-111-2222', 1),
('West Branch', '789 Oak St, City A', '123-333-4444', 1),
('Downtown Branch', '456 Elm St, City B', '987-777-8888', 2);

-- Insert Data into Author Table
INSERT INTO Author (Name, Nationality, DateOfBirth) VALUES
('F. Scott Fitzgerald', 'American', '1896-09-24'),
('Harper Lee', 'American', '1926-04-28');

-- Insert Data into BookAuthor Table
INSERT INTO BookAuthor (BookID, AuthorID) VALUES
(1, 1),
(2, 2);

-- Insert Data into Category Table
INSERT INTO Category (CategoryName, Description) VALUES
('Classic', 'Timeless literature that has cultural significance'),
('Novel', 'A long narrative work of fiction');

-- Insert Data into BookCategory Table
INSERT INTO BookCategory (BookID, CategoryID) VALUES
(1, 1),
(2, 2);

-- Insert Data into Member Table
INSERT INTO Member (Name, Email, PhoneNumber, Address, DateOfMembership) VALUES
('Alice Johnson', 'alice@example.com', '555-1234', '101 Pine St, City A', '2023-01-15'),
('Bob Smith', 'bob@example.com', '555-5678', '202 Maple Ave, City B', '2023-02-10');

-- Insert Data into MembershipType Table
INSERT INTO MembershipType (TypeName, MaxBooksAllowed, DurationInDays, Fee) VALUES
('Standard', 5, 30, 10.00),
('Premium', 10, 60, 20.00);

-- Insert Data into Librarian Table
INSERT INTO Librarian (Name, Email, PhoneNumber, DateOfJoining, LibraryID) VALUES
('Emily Davis', 'emily@library.com', '555-9999', '2022-06-01', 1),
('John Williams', 'john@library.com', '555-8888', '2021-09-15', 2);

-- Insert Data into Issue Table
INSERT INTO Issue (MemberID, LibrarianID, IssueDate, DueDate) VALUES
(1, 1, '2024-02-01', '2024-03-01'),
(2, 2, '2024-02-05', '2024-03-05');

-- Insert Data into IssueDetail Table
INSERT INTO IssueDetail (IssueID, BookID, ReturnDate, Fine) VALUES
(1, 1, '2024-02-28', 0),
(2, 2, NULL, 0);

-- Insert Data into Fine Table
INSERT INTO Fine (IssueDetailID, Amount, PaidDate, Status) VALUES
(1, 0.00, '2024-02-28', 'Paid'),
(2, 5.00, NULL, 'Pending');

-- Insert Data into Reservation Table
INSERT INTO Reservation (MemberID, BookID, ReservationDate, Status) VALUES
(1, 2, '2024-02-10', 'Active'),
(2, 1, '2024-02-12', 'Cancelled');

-- Insert Data into Event Table
INSERT INTO Event (BranchID, EventName, Description, EventDate) VALUES
(1, 'Book Reading', 'A public book reading session', '2024-03-10'),
(2, 'Author Meetup', 'Meet the famous author Harper Lee', '2024-04-15');

-- Insert Data into Feedback Table
INSERT INTO Feedback (MemberID, BookID, Rating, Comment, FeedbackDate) VALUES
(1, 1, 5, 'Amazing book, highly recommend!', '2024-02-20'),
(2, 2, 4, 'Great book but a bit slow-paced.', '2024-02-22');
