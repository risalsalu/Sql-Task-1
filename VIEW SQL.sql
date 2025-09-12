DROP VIEW IF EXISTS BookAuthorDetail
GO

CREATE VIEW BookAuthorDetail
AS 
SELECT
b.BookID,
b.Title AS BookTitles,
b.PublisherID,
a.AuthorID,
a.AuthorName,
a.BirthYear


FROM Books b
INNER JOIN Authors a ON b.AuthorID = a.AuthorID
GO 

SELECT * FROM BookAuthorDetail;
