DROP TABLE IF EXISTS Book;
DROP TABLE IF EXISTS Author;
DROP TABLE IF EXISTS Publisher;

CREATE TABLE Author (
    AuthorID INT PRIMARY KEY IDENTITY(1,1),
    AuthorName VARCHAR(100) NOT NULL,
    Country VARCHAR(50)
);

CREATE TABLE Publisher (
    PublisherID INT PRIMARY KEY IDENTITY(1,1),
    PublisherName VARCHAR(100) NOT NULL,
    Location VARCHAR(100)
);

CREATE TABLE Book (
    BookID INT PRIMARY KEY IDENTITY(1,1),
    Title VARCHAR(200) NOT NULL,
    PublicationYear INT CHECK (PublicationYear > 0),
    AuthorID INT,
    PublisherID INT,
    FOREIGN KEY (AuthorID) REFERENCES Author(AuthorID)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (PublisherID) REFERENCES Publisher(PublisherID)
        ON UPDATE CASCADE ON DELETE CASCADE
);

BEGIN TRANSACTION;
INSERT INTO Author (AuthorName, Country)
VALUES 
    ('George Orwell', 'UK'),
    ('J.K. Rowling', 'UK'),
    ('Mark Twain', 'USA');

INSERT INTO Publisher (PublisherName, Location)
VALUES 
    ('Penguin Books', 'London'),
    ('Bloomsbury', 'London'),
    ('HarperCollins', 'New York');

INSERT INTO Book (Title, PublicationYear, AuthorID, PublisherID)
VALUES
    ('1984', 1949, 1, 1),
    ('Animal Farm', 1945, 1, 1),
    ('Harry Potter and the Philosopher''s Stone', 1997, 2, 2),
    ('Adventures of Huckleberry Finn', 1884, 3, 3);
COMMIT;

SELECT b.Title AS BookTitle, b.PublicationYear, a.AuthorName, p.PublisherName
FROM Book b
INNER JOIN Author a ON b.AuthorID = a.AuthorID
INNER JOIN Publisher p ON b.PublisherID = p.PublisherID
ORDER BY b.PublicationYear;

SELECT b.Title AS BookTitle, a.AuthorName
FROM Book b
LEFT JOIN Author a ON b.AuthorID = a.AuthorID
ORDER BY b.Title;

SELECT b.Title AS BookTitle, p.PublisherName
FROM Book b
RIGHT JOIN Publisher p ON b.PublisherID = p.PublisherID
ORDER BY p.PublisherName;

SELECT b.Title AS BookTitle, a.AuthorName, p.PublisherName
FROM Book b
FULL OUTER JOIN Author a ON b.AuthorID = a.AuthorID
FULL OUTER JOIN Publisher p ON b.PublisherID = p.PublisherID
ORDER BY b.Title, a.AuthorName, p.PublisherName;

SELECT AuthorName AS Name FROM Author
UNION
SELECT PublisherName FROM Publisher
ORDER BY Name;

SELECT AuthorName AS Name FROM Author
UNION ALL
SELECT PublisherName FROM Publisher
ORDER BY Name;

DELETE FROM Author WHERE AuthorID = 1;

SELECT * FROM Book;
