-- Create Database
CREATE DATABASE LibraryManagement1;
USE LibraryManagement1;

-- Library Table
CREATE TABLE Library (
    LibraryID INT PRIMARY KEY AUTO_INCREMENT,
    LibraryName VARCHAR(255) NOT NULL,
    Address TEXT NOT NULL,
    ContactNumber VARCHAR(20) NOT NULL
);

-- Publisher Table (Move this before Book table)
CREATE TABLE Publisher (
    PublisherID INT PRIMARY KEY AUTO_INCREMENT,
    PublisherName VARCHAR(255) NOT NULL,
    Address TEXT,
    ContactNumber VARCHAR(20)
);

-- Book Table (Now it can reference Publisher)
CREATE TABLE Book (
    BookID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(255) NOT NULL,
    ISBN VARCHAR(20) NOT NULL UNIQUE,
    PublisherID INT,
    Edition VARCHAR(50),
    Genre VARCHAR(100),
    PublishedYear INT,
    Pages INT,
    FOREIGN KEY (PublisherID) REFERENCES Publisher(PublisherID) ON DELETE CASCADE
);

-- LibraryBranch Table
CREATE TABLE LibraryBranch (
    BranchID INT PRIMARY KEY AUTO_INCREMENT,
    BranchName VARCHAR(255) NOT NULL,
    Address TEXT NOT NULL,
    ContactNumber VARCHAR(20) NOT NULL,
    LibraryID INT,
    FOREIGN KEY (LibraryID) REFERENCES Library(LibraryID) ON DELETE CASCADE
);

-- Author Table
CREATE TABLE Author (
    AuthorID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL,
    Nationality VARCHAR(100),
    DateOfBirth DATE
);

-- BookAuthor (Many-to-Many Relationship)
CREATE TABLE BookAuthor (
    BookAuthorID INT PRIMARY KEY AUTO_INCREMENT,
    BookID INT,
    AuthorID INT,
    FOREIGN KEY (BookID) REFERENCES Book(BookID) ON DELETE CASCADE,
    FOREIGN KEY (AuthorID) REFERENCES Author(AuthorID) ON DELETE CASCADE
);

-- Category Table
CREATE TABLE Category (
    CategoryID INT PRIMARY KEY AUTO_INCREMENT,
    CategoryName VARCHAR(100) NOT NULL,
    Description TEXT
);

-- BookCategory (Many-to-Many Relationship)
CREATE TABLE BookCategory (
    BookCategoryID INT PRIMARY KEY AUTO_INCREMENT,
    BookID INT,
    CategoryID INT,
    FOREIGN KEY (BookID) REFERENCES Book(BookID) ON DELETE CASCADE,
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID) ON DELETE CASCADE
);

-- Member Table
CREATE TABLE Member (
    MemberID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    PhoneNumber VARCHAR(20),
    Address TEXT,
    DateOfMembership DATE NOT NULL
);

-- MembershipType Table
CREATE TABLE MembershipType (
    MembershipTypeID INT PRIMARY KEY AUTO_INCREMENT,
    TypeName VARCHAR(100) NOT NULL,
    MaxBooksAllowed INT NOT NULL,
    DurationInDays INT NOT NULL,
    Fee DECIMAL(10,2) NOT NULL
);

-- Librarian Table
CREATE TABLE Librarian (
    LibrarianID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    PhoneNumber VARCHAR(20),
    DateOfJoining DATE NOT NULL,
    LibraryID INT,
    FOREIGN KEY (LibraryID) REFERENCES Library(LibraryID) ON DELETE CASCADE
);

-- Issue Table
CREATE TABLE Issue (
    IssueID INT PRIMARY KEY AUTO_INCREMENT,
    MemberID INT,
    LibrarianID INT,
    IssueDate DATE NOT NULL,
    DueDate DATE NOT NULL,
    FOREIGN KEY (MemberID) REFERENCES Member(MemberID) ON DELETE CASCADE,
    FOREIGN KEY (LibrarianID) REFERENCES Librarian(LibrarianID) ON DELETE CASCADE
);

-- IssueDetail Table
CREATE TABLE IssueDetail (
    IssueDetailID INT PRIMARY KEY AUTO_INCREMENT,
    IssueID INT,
    BookID INT,
    ReturnDate DATE,
    Fine DECIMAL(10,2) DEFAULT 0,
    FOREIGN KEY (IssueID) REFERENCES Issue(IssueID) ON DELETE CASCADE,
    FOREIGN KEY (BookID) REFERENCES Book(BookID) ON DELETE CASCADE
);

-- Fine Table
CREATE TABLE Fine (
    FineID INT PRIMARY KEY AUTO_INCREMENT,
    IssueDetailID INT,
    Amount DECIMAL(10,2) NOT NULL,
    PaidDate DATE,
    Status VARCHAR(50) NOT NULL,
    FOREIGN KEY (IssueDetailID) REFERENCES IssueDetail(IssueDetailID) ON DELETE CASCADE
);

-- Reservation Table
CREATE TABLE Reservation (
    ReservationID INT PRIMARY KEY AUTO_INCREMENT,
    MemberID INT,
    BookID INT,
    ReservationDate DATE NOT NULL,
    Status VARCHAR(50) NOT NULL,
    FOREIGN KEY (MemberID) REFERENCES Member(MemberID) ON DELETE CASCADE,
    FOREIGN KEY (BookID) REFERENCES Book(BookID) ON DELETE CASCADE
);

-- Event Table
CREATE TABLE Event (
    EventID INT PRIMARY KEY AUTO_INCREMENT,
    BranchID INT,
    EventName VARCHAR(255) NOT NULL,
    Description TEXT,
    EventDate DATE NOT NULL,
    FOREIGN KEY (BranchID) REFERENCES LibraryBranch(BranchID) ON DELETE CASCADE
);

-- Feedback Table
CREATE TABLE Feedback (
    FeedbackID INT PRIMARY KEY AUTO_INCREMENT,
    MemberID INT,
    BookID INT,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comment TEXT,
    FeedbackDate DATE NOT NULL,
    FOREIGN KEY (MemberID) REFERENCES Member(MemberID) ON DELETE CASCADE,
    FOREIGN KEY (BookID) REFERENCES Book(BookID) ON DELETE CASCADE
); 