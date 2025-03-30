-- Create Database
CREATE DATABASE OnlineBookstore;
USE OnlineBookstore;

-- Create Authors Table
CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL UNIQUE,
    Country VARCHAR(50)
);

-- Create Books Table
CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(100) NOT NULL UNIQUE,
    AuthorID INT,
    Genre VARCHAR(50),
    Price DECIMAL(10,2) CHECK (Price > 0),
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID) ON DELETE CASCADE
);

-- Create Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15) UNIQUE NOT NULL,
    Address VARCHAR(255) NOT NULL
);

-- Create Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    BookID INT,
    OrderDate DATE NOT NULL DEFAULT (CURRENT_DATE),
    Quantity INT CHECK (Quantity > 0),
    TotalPrice DECIMAL(10,2) CHECK (TotalPrice >= 0),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID) ON DELETE CASCADE
);

-- Insert Data into Authors
INSERT INTO Authors (AuthorID, Name, Country)
VALUES 
    (1, 'John Smith', 'USA'),
    (2, 'Jane Doe', 'UK'),
    (3, 'Dan Brown', 'USA'),
    (4, 'J.K. Rowling', 'UK');

-- Insert Data into Books
INSERT INTO Books (BookID, Title, AuthorID, Genre, Price)
VALUES 
    (1, 'SQL Basics', 1, 'Tech', 450.00),
    (2, 'Java Mastery', 2, 'Programming', 599.99),
    (3, 'The Da Vinci Code', 3, 'Thriller', 699.00),
    (4, 'Harry Potter', 4, 'Fantasy', 999.00);

-- Insert Data into Customers
INSERT INTO Customers (CustomerID, Name, Email, Phone, Address)
VALUES 
    (1, 'Fathima Roselina', 'fathima@gmail.com', '1234567890', 'Velachery, Chennai'),
    (2, 'Alex John', 'alex@gmail.com', '9876543210', 'Anna Nagar, Chennai');

-- Insert Data into Orders
INSERT INTO Orders (OrderID, CustomerID, BookID, OrderDate, Quantity, TotalPrice)
VALUES 
    (1, 1, 1, '2025-03-12', 2, 900.00),
    (2, 2, 2, '2025-03-13', 1, 599.99);

-- Read Operations
SELECT * FROM Authors;
SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

-- Read Books with Author Details
SELECT Books.Title, Authors.Name AS Author, Books.Genre, Books.Price
FROM Books
JOIN Authors ON Books.AuthorID = Authors.AuthorID;

-- Read Orders with Customer and Book Details
SELECT Orders.OrderID, Customers.Name AS Customer, Books.Title AS Book, Orders.OrderDate, Orders.Quantity, Orders.TotalPrice
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
JOIN Books ON Orders.BookID = Books.BookID;

-- Update Operations
UPDATE Books SET Price = 500.00 WHERE BookID = 1;
UPDATE Customers SET Phone = '9999999999' WHERE CustomerID = 1;

-- Delete Operations
DELETE FROM Orders WHERE OrderID = 1;
DELETE FROM Customers WHERE CustomerID = 2;