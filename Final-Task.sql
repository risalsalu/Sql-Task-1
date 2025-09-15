CREATE PROCEDURE CheckoutBook
    @MemberID INT,
    @CopyID INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if book is available
    IF EXISTS (SELECT 1 FROM BookCopies WHERE CopyID = @CopyID AND IsAvailable = 1)
    BEGIN
        -- Insert borrowing record
        INSERT INTO Borrowing (CopyID, UserID, BorrowDate, ReturnDate)
        VALUES (@CopyID, @MemberID, GETDATE(), NULL);

        -- Update book copy status
        UPDATE BookCopies
        SET IsAvailable = 0
        WHERE CopyID = @CopyID;
    END
    ELSE
    BEGIN
        PRINT 'Book is not available!';
    END
END;
GO

CREATE PROCEDURE ReturnBook
    @MemberID INT,
    @CopyID INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Update the borrowing record
    UPDATE Borrowing
    SET ReturnDate = GETDATE()
    WHERE CopyID = @CopyID
      AND UserID = @MemberID
      AND ReturnDate IS NULL;

    -- Update book copy status
    UPDATE BookCopies
    SET IsAvailable = 1
    WHERE CopyID = @CopyID;
END;
GO

CREATE FUNCTION GetBookCountByAuthor (@AuthorID INT)
RETURNS INT
AS
BEGIN
    DECLARE @BookCount INT;

    SELECT @BookCount = COUNT(*)
    FROM Books
    WHERE AuthorID = @AuthorID;

    RETURN @BookCount;
END;
GO

SELECT dbo.GetBookCountByAuthor(1) AS TotalBooks;

CREATE FUNCTION GetOverdueBorrowings()
RETURNS TABLE
AS
RETURN
(
    SELECT b.BorrowID, b.CopyID, b.UserID, b.BorrowDate
    FROM Borrowing b
    WHERE b.ReturnDate IS NULL
      AND DATEDIFF(DAY, b.BorrowDate, GETDATE()) > 7
);
GO

SELECT * FROM dbo.GetOverdueBorrowings();

