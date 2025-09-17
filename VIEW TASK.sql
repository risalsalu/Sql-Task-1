DROP TABLE IF EXISTS Books;
GO
DROP TABLE IF EXISTS Authors;
GO

CREATE TABLE Authors(
AuthorID INT PRIMARY KEY,
AuthorName VARCHAR(50)
);

CREATE TABLE Books(
BookID INT PRIMARY KEY,
BookName VARCHAR(50),
BookPrice DECIMAL (10,2),
AuthorID INT FOREIGN KEY REFERENCES Authors (AuthorID)
);

INSERT INTO Authors(AuthorID,AuthorName)VALUES 
(1,'AJAY'),
(2,'ANAND'),
(3,'ANAS'),
(4,'DIYAN')

INSERT INTO Books(BookID,BookName,BookPrice,AuthorID)VALUES 
(1,'Book1',200,3),
(2,'Book2',150,1),
(3,'Book3',130,1),
(4,'Book4',125,2)

DROP VIEW IF EXISTS BookAuthor
GO

CREATE VIEW	BookAuthor
AS 
SELECT b.BookID,b.BookName,b.BookPrice,a.AuthorID,a.AuthorName
FROM Books b
INNER JOIN Authors a ON b.AuthorID =a.AuthorID

SELECT * FROM BookAuthor