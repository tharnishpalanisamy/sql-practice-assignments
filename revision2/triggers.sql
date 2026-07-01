-- ============================================
-- DROP TABLES
-- ============================================

DROP TABLE IF EXISTS EmployeeAudit;
DROP TABLE IF EXISTS DeletedEmployees;
DROP TABLE IF EXISTS EmployeeLogs;
DROP TABLE IF EXISTS Employees;

-- ============================================
-- EMPLOYEES TABLE
-- ============================================

CREATE TABLE Employees
(
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    HireDate DATE
);

-- ============================================
-- AUDIT TABLE
-- ============================================

CREATE TABLE EmployeeAudit
(
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    EmpID INT,
    ActionType VARCHAR(20),
    OldSalary DECIMAL(10,2),
    NewSalary DECIMAL(10,2),
    ActionDate DATETIME DEFAULT GETDATE()
);

-- ============================================
-- DELETED EMPLOYEES TABLE
-- ============================================

CREATE TABLE DeletedEmployees
(
    EmpID INT,
    EmpName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    HireDate DATE,
    DeletedDate DATETIME DEFAULT GETDATE()
);

-- ============================================
-- INSERT LOG TABLE
-- ============================================

CREATE TABLE EmployeeLogs
(
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    EmpID INT,
    Message VARCHAR(200),
    LogDate DATETIME DEFAULT GETDATE()
);

-- ============================================
-- INSERT SAMPLE DATA
-- ============================================

INSERT INTO Employees
VALUES
(101,'Arun','HR',35000,'2021-01-10'),
(102,'Bala','IT',60000,'2020-03-15'),
(103,'Charan','Finance',55000,'2019-07-21'),
(104,'Divya','IT',70000,'2018-09-11'),
(105,'Eswar','Sales',42000,'2022-06-01'),
(106,'Farah','HR',38000,'2023-02-15'),
(107,'Gokul','Finance',65000,'2017-12-20'),
(108,'Hari','Marketing',45000,'2021-11-25');



--Phase 13 – Triggers
--Q76

--Audit trigger.

create trigger auditTrigger 
on Employees  
after insert , update , delete 
as 
begin 
	if exists (select 1 from inserted ) and exists (select 1 from deleted ) 
	begin 
		insert into EmployeeAudit (EmpID , ActionType , OldSalary , NewSalary , ActionDate ) 
		select i.EmpID , 'Update' , d.Salary , i.Salary , GETDATE()
		from inserted i 
		join deleted d 
		on i.EmpID = d.EmpID 
	end 


	else if exists(select 1 from deleted) and not exists (select 1 from inserted ) 
	begin 
		insert into DeletedEmployees 
		select *, GETDATE() from deleted
	end 

	else if exists(select 1 from inserted ) and not exists (select 1 from deleted) 
	begin 
		insert into EmployeeLogs (EmpID , message) select empId , 'Inserted' from inserted 
	end 
end		

select * from Employees

insert into Employees values (109 , 'tharnish' , 'IT' , 50000000 , GETDATE())
select * from EmployeeLogs
select * from DeletedEmployees
delete from Employees where EmpID = 105

--Q77

--Prevent negative salary.

create trigger preventNegative 
on employees 
after insert , update 
as
begin 
	if exists (select 1 from inserted where Salary < 0 ) 
	begin 
		RAISERROR('Salary cannot be negative' , 16, 1) 
		rollback transaction 
	end 
end 

update Employees set Salary = -5000 where EmpID = 101 

drop trigger auditTrigger
select * from Employees

--Q78

--Auto log deleted records.
--already did 
--Q79

--AFTER INSERT trigger.
--Q80

--INSTEAD OF DELETE trigger.

alter table employees add active int 


select * from Employees 

update Employees set active = 1

create trigger preventDelete2 
on employees 
instead of delete 
as 
begin 
	update Employees 
	set active = 0 
	where EmpID in 
	(
	select EmpID 
	from deleted )
end 

delete from Employees where salary < 50000 