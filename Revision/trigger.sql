--Phase 13 – Triggers

-- Clean up previous tables if they exist
DROP TABLE IF EXISTS SalaryAuditLog;
DROP TABLE IF EXISTS EmployeeLogs;
DROP TABLE IF EXISTS EmployeeSalaries;
GO

-- Create Core Employee Salary Table
CREATE TABLE EmployeeSalaries (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(100) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    Salary DECIMAL(18,2) NOT NULL
);

-- Create Dedicated Audit Log Table
CREATE TABLE SalaryAuditLog (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    EmpID INT,
    ActionType VARCHAR(20),       -- 'INSERT', 'UPDATE', or 'DELETE'
    OldSalary DECIMAL(18,2),
    NewSalary DECIMAL(18,2),
    ChangedBy VARCHAR(100) DEFAULT SYSTEM_USER,
    ChangedDate DATETIME DEFAULT GETDATE()
);
GO

-- Insert Initial Sample Data
INSERT INTO EmployeeSalaries (EmpID, EmpName, Department, Salary) VALUES 
(101, 'Alice Smith', 'HR', 60000.00),
(102, 'Bob Jones', 'IT', 90000.00),
(103, 'Charlie Brown', 'Sales', 50000.00);
GO

--Q76

--Audit trigger.

CREATE TRIGGER trg_GenericEmployeeAudit
ON EmployeeSalaries  
AFTER INSERT , UPDATE , DELETE 
AS
BEGIN
SET NOCOUNT ON 
	
	IF EXISTS(SELECT 1 FROM INSERTED) AND NOT EXISTS(SELECT 1  FROM DELETED ) 

	BEGIN 

	INSERT INTO SalaryAuditLog (EMPID , ACTIONTYPE ,OLDSALARY , NEWSALARY   ) 
	SELECT EMPID , 'INSERTED' , NULL , SALARY 
	FROM INSERTED ; 

	END


	ELSE IF EXISTS(SELECT 1 FROM DELETED ) AND  EXISTS (SELECT 1 FROM INSERTED ) 

	BEGIN 
		INSERT INTO SalaryAuditLog (EMPID , ActionType , OldSalary , NewSalary ) 
		SELECT I.EMPID , 'UPDATE' , D.SALARY , I.SALARY 
		FROM INSERTED I 
		JOIN DELETED D 
		ON I.EMPID = D.EMPID
	END 

	IF EXISTS(SELECT 1 FROM DELETED ) AND  NOT EXISTS (SELECT 1 FROM INSERTED ) 
	BEGIN 
		INSERT INTO SalaryAuditLog (EmpID , ActionType , OldSalary , NewSalary ) 
		SELECT EMPID , 'DELETED' , SALARY , NULL 
		FROM DELETED 
	END  


END


DELETE FROM EmployeeSalaries WHERE EmpID = 101

SELECT * FROM SalaryAuditLog


--Prevent negative salary.

--Q78

CREATE TRIGGER PREVENTNEGATIVE 
ON EmployeeSalaries 
AFTER UPDATE , INSERT 
AS
BEGIN 
SET NOCOUNT ON 
	IF EXISTS (SELECT 1 FROM INSERTED WHERE SALARY < 0 )
	BEGIN 
		RAISERROR('SALARY CANNOT BE NEGATIVE' , 16 , 1 ) 
		ROLLBACK TRANSACTION 
	END 
END 
	
INSERT INTO EmployeeSalaries (EmpID, EmpName, Department, Salary) VALUES 
(109, 'Alice Smith', 'HR', -60000.00)

--Auto log deleted records.
--ALREADY DONE 
--Q79

--AFTER INSERT trigger. 
--ALREADY DONE 

--Q80
ALTER TABLE EmployeeSalaries ADD isDELETED VARCHAR(20) ; 
--INSTEAD OF DELETE trigger.
ALTER TRIGGER PREVENTDELETE 
ON EmployeeSalaries 
INSTEAD OF DELETE 
AS 
BEGIN 
	SET NOCOUNT ON 
	PRINT 'YOU DO NOT HAVE ACCESS TO DELETE ' 
	UPDATE EmployeeSalaries 
	SET ISDELETED = 'TRUE' 
	FROM EmployeeSalaries E 
	JOIN DELETED D 
	ON E.EmpID = D.EmpID 
END 

DELETE FROM EmployeeSalaries WHERE EmpID = 102 


