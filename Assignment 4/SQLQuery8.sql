--1. Create a DML trigger to restrict DML operations on Saturday and Sunday.

CREATE TRIGGER restrictOperations 
on student 
AFTER INSERT,UPDATE,DELETE 
AS
BEGIN 
	IF DATENAME(WEEKDAY, GETDATE()) IN ('Saturday', 'Sunday')
		BEGIN
			PRINT 'Transaction rolledBack'
			ROLLBACK TRANSACTION 
		END
END

insert into student values 
(25,'vinoth',4,500,500)

--2. Create a DML trigger to restrict delete operations between 11:00AM to 15:00PM.

CREATE TRIGGER restrictDelete 
on student 
AFTER DELETE
AS 
BEGIN
declare @currentTime int
set @currentTime = DATEPART(HOUR,GETDATE()) 

if @currentTime between 11 and 15 
BEGIN 
PRINT 'Cannot perform delete operation in this time'
	ROLLBACK TRANSACTION
END

END

--3. Create a DDL trigger to show notification whenever a CREATE, ALTER, DROP, RENAME operation is performed.

CREATE TRIGGER ddlTrigger 
on DATABASE
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE, CREATE_PROCEDURE, ALTER_PROCEDURE, DROP_PROCEDURE,RENAME 
As 
BEGIN 
	PRINT 'A DDL operation was performed'
END

CREATE TABLE test(
    id INT
)
DROP TRIGGER ddlTrigger ON DATABASE
--5. Create INSTEAD OF trigger when DELETE query is executed on Employee table to include Soft delete.

CREATE TABLE Employee(
    empId INT PRIMARY KEY,
    empName VARCHAR(30),
    salary INT,
    isDeleted BIT DEFAULT 0
)

INSERT INTO Employee VALUES
(1, 'Ram', 50000, 0),
(2, 'Arun', 45000, 0),
(3, 'David', 60000, 0)

CREATE TRIGGER softDeleteTrigger
ON Employee
INSTEAD OF DELETE
AS
BEGIN

    UPDATE Employee
    SET isDeleted = 1
    WHERE empId IN (
        SELECT empId FROM deleted
    )

    PRINT 'Soft Delete Performed'

END

delete from Employee where empId = 1
select * from Employee 