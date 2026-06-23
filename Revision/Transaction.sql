----This came from your Merge assignment.

----Phase 15 – Cursors

--CREATE TABLE Students (
--    StudentID INT PRIMARY KEY,
--    StudentName VARCHAR(50),
--    Marks INT,
--    Grade CHAR(1)
--);

--INSERT INTO Students VALUES
--(1,'Arun',95,NULL),
--(2,'Bala',82,NULL),
--(3,'Charan',76,NULL),
--(4,'Deepak',68,NULL),
--(5,'Ezhil',55,NULL);

----Don't waste time doing many cursor problems.

----Just revise:

----Q83

----Update grades using cursor.

--DECLARE @MARK INT ; 
--DECLARE @NAME VARCHAR(30) ; 
--DECLARE gradeCursor 
--CURSOR FOR
--SELECT StudentName ,  Marks 
--FROM Students 

--OPEN gradeCursor

--FETCH NEXT FROM gradeCursor INTO  @NAME , @MARK ; 

--WHILE @@FETCH_STATUS = 0  
--BEGIN 
--IF @MARK > 90 
--BEGIN 

--	PRINT @NAME + ' ' + CAST(@MARK AS VARCHAR(10)) + ' A' 
--END
--ELSE IF @MARK > 80 
--BEGIN 
--	PRINT @NAME + ' ' + CAST(@MARK AS VARCHAR(10)) + ' B'
--END
--ELSE IF @MARK > 70 
--BEGIN 
--	PRINT @NAME + ' ' + CAST(@MARK AS VARCHAR(10)) + ' C'
--END



--FETCH NEXT FROM gradeCursor INTO @NAME, @MARK ;
--END
--CLOSE gradeCursor 
--DEALLOCATE gradeCursor

--Q84

--Salary calculation using cursor.

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(50),
    Salary DECIMAL(10,2),
    UpdatedSalary DECIMAL(10,2)
);

INSERT INTO Employees VALUES
(101,'Ravi',25000,NULL),
(102,'Kumar',35000,NULL),
(103,'Priya',45000,NULL),
(104,'Meena',55000,NULL),
(105,'Vijay',65000,NULL);

DECLARE @SALARY DECIMAL(10,2) 
DECLARE @NAME VARCHAR(30) ; 
DECLARE salaryCursor 
CURSOR FOR
SELECT EmployeeName , SALARY
FROM Employees 

OPEN salaryCursor 
FETCH NEXT FROM salaryCursor INTO @NAME , @SALARY 

WHILE @@FETCH_STATUS = 0 
BEGIN 

IF @SALARY > 50000 
BEGIN 
	PRINT @NAME + ' ' + CAST(@SALARY AS VARCHAR(20)) + ' ' + CAST(@SALARY * 0.2 AS VARCHAR(10)) 
END 

ELSE
BEGIN 
	PRINT @NAME + ' ' + CAST(@SALARY AS VARCHAR(20)) + ' ' + CAST(@SALARY * 0.3 AS VARCHAR(10)) 
END

FETCH NEXT FROM salaryCursor INTO @NAME , @SALARY 

END 
CLOSE salaryCursor 
DEALLOCATE salaryCursor 
--Q85

--Loop through records and generate report.

--That's enough.