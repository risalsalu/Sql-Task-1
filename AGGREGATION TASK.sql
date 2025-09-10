DROP TABLE IF EXISTS Sales;

CREATE TABLE Sales(
    SaleID INT PRIMARY KEY,
    BookID INT,
    SaleDate DATE,
    SaleAmount DECIMAL(10,2) CHECK (SaleAmount >= 0),
    CONSTRAINT Sales_Book FOREIGN KEY (BookID)
        REFERENCES Books(BookID)
        ON DELETE CASCADE
);
GO

INSERT INTO Sales(SaleID,BookID,SaleDate,SaleAmount) VALUES
(1,1, '2025-01-05', 239),
(2,1, '2025-02-10', 239),
(3,2, '2025-01-15', 220),
(4,2, '2025-03-12', 220),
(5,3, '2025-01-20', 289),
(6,3, '2025-04-05', 289),
(7,4, '2025-02-01', 230),
(8,5, '2025-03-10', 339),
(9,5, '2025-05-15', 339);
GO

SELECT B.Title, SUM(S.SaleAmount) AS TotalSales
FROM Books B
JOIN Sales S ON B.BookID = S.BookID
GROUP BY B.Title;
GO

SELECT B.Title, YEAR(S.SaleDate) AS SaleYear, SUM(S.SaleAmount) AS TotalSales
FROM Books B
JOIN Sales S ON B.BookID = S.BookID
GROUP BY B.Title, YEAR(S.SaleDate)
ORDER BY B.Title, SaleYear;
GO

SELECT B.Title, SUM(S.SaleAmount) AS TotalSales
FROM Books B
JOIN Sales S ON B.BookID = S.BookID
GROUP BY B.Title
HAVING SUM(S.SaleAmount) > 500;
GO

CREATE PROCEDURE dbo.GetTotalSalesByBook
    @BookTitle VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT B.Title, SUM(S.SaleAmount) AS TotalSales
    FROM Books B
    JOIN Sales S ON B.BookID = S.BookID
    WHERE B.Title = @BookTitle
    GROUP BY B.Title;
END;
GO

EXEC dbo.GetTotalSalesByBook @BookTitle = 'NANO';
GO

CREATE FUNCTION dbo.AvgSaleAmount (@BookID INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @Avg DECIMAL(10,2);

    SELECT @Avg = AVG(SaleAmount)
    FROM Sales
    WHERE BookID = @BookID;

    RETURN @Avg;
END;
GO

SELECT B.Title, dbo.AvgSaleAmount(B.BookID) AS AvgSale
FROM Books B;
GO
