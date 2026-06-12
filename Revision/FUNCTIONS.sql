--Phase 12 – Functions

-- Clean up previous table if it exists
DROP TABLE IF EXISTS Staff;
GO

-- Create the practice table
CREATE TABLE Staff (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    Salary DECIMAL(18,2) NOT NULL
);
GO

-- Insert Sample Data
INSERT INTO Staff (EmployeeID, FirstName, LastName, Department, Salary) VALUES 
(101, 'Alice', 'Smith', 'HR', 60000.00),
(102, 'Bob', 'Jones', 'IT', 90000.00),
(103, 'Charlie', 'Brown', 'Sales', 50000.00),
(104, 'David', 'Green', 'HR', 75000.00),
(105, 'Emma', 'Watson', 'IT', 120000.00);
GO


--Scalar
--Q72

--Calculate bonus.

CREATE FUNCTION CALCULATEBONUS (
@SALARY DECIMAL(18,2) 
)
RETURNS DECIMAL(18,2)
AS
BEGIN 
	RETURN @SALARY * 0.2 
END 

SELECT * , DBO.CALCULATEBONUS(SALARY) AS BONUS
FROM Staff


--Q73

--Calculate percentage.
CREATE FUNCTION CALCULATEPERCENTAGE (
@VALUE DECIMAL(18,2) , 
@TOTAL DECIMAL(18,2) 
)
RETURNS DECIMAL(18,2) 
AS 
BEGIN 
	RETURN @VALUE * 100 / @TOTAL 
END 

SELECT * , DBO.CALCULATEPERCENTAGE(SALARY , SUM(SALARY) OVER() ) 
FROM Staff 


--Table Valued
--Q74
--Return all employees in HR.
CREATE FUNCTION ALLEMP (
@DEPTNAME VARCHAR(40) )   
RETURNS TABLE 
AS
RETURN (
SELECT * 
FROM Staff WHERE Department = @DEPTNAME 
)

SELECT * FROM DBO.ALLEMP('HR')



--Q75

--Return employees above average salary.
CREATE FUNCTION ABOVEAVG()
RETURNS TABLE 
AS 
RETURN 
SELECT * 
FROM Staff 
WHERE Salary > 
(
SELECT AVG(SALARY) FROM Staff ) 


SELECT * FROM DBO.ABOVEAVG()
--Covered in your assignments.