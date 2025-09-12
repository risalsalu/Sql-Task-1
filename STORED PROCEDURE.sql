DROP PROCEDURE IF EXISTS GetAllBookNames
GO
DROP PROCEDURE IF EXISTS GetBooksByWriter
GO
DROP FUNCTION IF EXISTS GetBookCountByAuthor
GO

CREATE PROCEDURE GetAllBookNames
AS
BEGIN
    SELECT Title
    FROM Books;
END;
GO

CREATE PROCEDURE GetBooksByWriter
    @AuthorName VARCHAR(100)
AS
BEGIN
    SELECT b.Title
    FROM Books b
    INNER JOIN Authors a ON b.AuthorID = a.AuthorID
    WHERE a.AuthorName = @AuthorName;
END;
GO

CREATE FUNCTION GetBookCountByAuthor(@AuthorName VARCHAR(100))
RETURNS INT
AS
BEGIN
    DECLARE @BookCount INT;

    SELECT @BookCount = COUNT(*)
    FROM Books b
    INNER JOIN Authors a ON b.AuthorID = a.AuthorID
    WHERE a.AuthorName = @AuthorName;

    RETURN @BookCount;
END;
GO

EXEC GetAllBookNames;

EXEC GetBooksByWriter @AuthorName = 'SAM';

SELECT dbo.GetBookCountByAuthor('DIYAN') AS BookCount;

