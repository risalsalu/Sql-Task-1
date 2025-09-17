DROP DATABASE IF EXISTS SchoolDB;
GO
DROP TABLE IF EXISTS Student
GO

CREATE DATABASE SchoolDB;
GO

USE SchoolDB;
GO

CREATE TABLE Student (
    StudentID INT PRIMARY KEY IDENTITY(1,1), -- auto-increment ID
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Age INT
);

INSERT INTO Student (FirstName, LastName, Age)
VALUES ('Muhammed', 'Anas', 20),
('Muhammed', 'Rizal', 25),
('Muhammed', 'Nidal', 22)


INSERT INTO Student (FirstName, LastName, Age)
VALUES ('Muhammed', 'Diyan', 22);

SELECT * FROM Student;

UPDATE Student
SET Age = 21
WHERE StudentID = 1;  

DELETE FROM Student
WHERE StudentID = 2;  
