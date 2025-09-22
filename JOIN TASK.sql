DROP TABLE IF EXISTS Publishers;
DROP TABLE IF EXISTS Authors;
DROP TABLE IF EXISTS Books;


CREATE TABLE Publishers(
PublisherID INT PRIMARY KEY,
PublisherName VARCHAR(100)NOT NULL UNIQUE,
Country VARCHAR(100)
);

CREATE table Authors(
AuthorID INT PRIMARY KEY,
AuthorName VARCHAR(100)NOT NULL,
BirthYear INT CHECK (BirthYear > 1900)
);

CREATE TABLE Books(
BookID INT PRIMARY KEY,
Title VARCHAR(100)NOT NULL,
AuthorID INT ,
PublisherID INT,
Price DECIMAL(10,2) CHECK(Price >0),
CONSTRAINT Book_Author FOREIGN KEY (AuthorID)
REFERENCES Authors(AuthorID)
ON UPDATE CASCADE
ON DELETE CASCADE,
CONSTRAINT Book_Publisher FOREIGN KEY (PublisherID)
REFERENCES Publishers(PublisherID)
ON UPDATE CASCADE
ON DELETE SET NULL
);


INSERT INTO Publishers(PublisherID,PublisherName,Country)VALUES
(1,'JOHN','INDIA'),
(2,'JAFAR','JAPAN'),
(3,'JANARDHAN','AMERICA'),
(4,'AJAY','GERMANY'),
(5,'ANAS','INDIA');


INSERT INTO Authors(AuthorID,AuthorName,BirthYear)VALUES
(1,'ADHARSH',1999),
(2,'RIZAL',2000),
(3,'DIYAN',2000),
(4,'SAM',2001),
(5,'AKSHAY',2002);

INSERT INTO Books(BookID,Title,AuthorID,PublisherID,Price)VALUES
(1,'NANO',3,4,239),
(2,'BOOK OF HEAVEN',5,1,220),
(3,'BOOK OF HELL',5,2,289),
(4,'STORY OF WHO',1,2,230),
(5,'BALARAMA',4,1,339)

SELECT * FROM Publishers;
SELECT * FROM Authors;
SELECT * FROM Books;

SELECT B.Title, A.AuthorName, P.PublisherName
FROM Books B
INNER JOIN Authors A ON B.AuthorID = A.AuthorID
INNER JOIN Publishers P ON B.PublisherID = P.PublisherID;

SELECT B.Title, A.AuthorName, P.PublisherName
FROM Books B
LEFT JOIN Authors A ON B.AuthorID = A.AuthorID
LEFT JOIN Publishers P ON B.PublisherID = P.PublisherID;

SELECT B.Title, P.PublisherName
FROM Books B
RIGHT JOIN Publishers P ON B.PublisherID = P.PublisherID;

SELECT B.Title, P.PublisherName
FROM Books B
FULL OUTER JOIN Publishers P ON B.PublisherID = P.PublisherID;

SELECT AuthorName AS Name FROM Authors
UNION
SELECT PublisherName FROM Publishers;

SELECT AuthorName AS Name FROM Authors
UNION ALL
SELECT PublisherName FROM Publishers;
