USE master;
GO

IF DB_ID(N'LibraryDB') IS NULL
BEGIN
    CREATE DATABASE LibraryDB;
END
GO

USE LibraryDB;
GO

IF OBJECT_ID(N'dbo.Books', N'U') IS NOT NULL
    DROP TABLE dbo.Books;
GO

CREATE TABLE dbo.Books
(
    BookID INT IDENTITY(1,1) PRIMARY KEY,
    Title  NVARCHAR(100) NOT NULL,
    Author NVARCHAR(100) NOT NULL,
    PublicationYear INT NOT NULL
);
GO

INSERT INTO dbo.Books (Title, Author, PublicationYear) VALUES
('To Kill a Mockingbird', 'Harper Lee', 1960),
('1984', 'George Orwell', 1949),
('Animal Farm', 'George Orwell', 1945),
('Pride and Prejudice', 'Jane Austen', 1813),
('The Great Gatsby', 'F. Scott Fitzgerald', 1925),
('The Catcher in the Rye', 'J.D. Salinger', 1951);
GO

USE LibraryDB;
GO
SELECT * FROM dbo.Books;


USE LibraryDB;
GO
DECLARE @Year INT = 1949;  
SELECT *
FROM dbo.Books
WHERE PublicationYear = @Year;

SELECT *
FROM dbo.Books
WHERE Author = 'George Orwell';

SELECT *
FROM dbo.Books
WHERE Author LIKE 'J%';
