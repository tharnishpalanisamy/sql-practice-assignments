--Phase 11 – Stored Procedures

-- ============================================
-- Phase 11 – Stored Procedures Practice
-- ============================================

-- DROP TABLE
DROP TABLE IF EXISTS Employees;

-- ============================================
-- CREATE TABLE
-- ============================================

CREATE TABLE Employees
(
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    City VARCHAR(50),
    JoinDate DATE
);

-- ============================================
-- INSERT DATA
-- ============================================

INSERT INTO Employees VALUES
(101,'Arun','IT',65000,'Chennai','2020-01-10'),
(102,'Priya','HR',42000,'Coimbatore','2021-03-15'),
(103,'Karthik','Finance',72000,'Madurai','2019-07-22'),
(104,'Sneha','IT',58000,'Bangalore','2022-05-11'),
(105,'Rahul','Sales',39000,'Salem','2023-01-08'),
(106,'Divya','HR',45000,'Chennai','2020-09-17'),
(107,'Vignesh','IT',91000,'Coimbatore','2018-12-01'),
(108,'Meena','Finance',68000,'Trichy','2021-08-13'),
(109,'Suresh','Sales',47000,'Erode','2019-11-25'),
(110,'Anitha','IT',76000,'Chennai','2022-04-20');
--Q66

--Procedure without parameters.

create procedure displayEmployees 
as
begin 
select * from Employees 
end 

exec displayEmployees

--Q67

--Procedure with input parameter.

create procedure insertEmployee 
@id int , 
@name varchar(30) , 
@dept varchar(20) , 
@salary decimal(10,2) , 
@city varchar(30) 
as
begin
insert into Employees Values (@id , @name , @dept , @salary , @city , GETDATE())
end 


exec insertEmployee 6 , 'Tharnish' , 'IT' , 5000000 , 'Coimbatore' 
exec displayEmployees

--Q68

--Procedure with output parameter.

create procedure employeeCount 
@dept varchar(50) , 
@count int output 

as  
begin 
	select  @count = Count(*) from Employees where Department = @dept 
end 

declare @total int 

exec employeeCount @dept = 'HR' , @count = @total output  

select @total


create procedure countEmp 
@count int output 
as
begin 
	select @count = Count(*) from employees 
end 

declare @total int 
exec countEmp @count = @total output 
select @total 



--Q69

--Procedure returning result set.
CREATE PROCEDURE GetITEmployees
AS
BEGIN
    SELECT *
    FROM Employees
    WHERE Department = 'IT';
END;
exec GetITEmployees

--Q70

--Procedure using transaction.
--Q71

--Procedure using TRY-CATCH.

alter procedure updateEmpName
@id int , 
@name varchar(50) 
as
begin 
set nocount on
	Begin TRANSACTION 
		begin try 
				update Employees set EmpName = @name where EmpID = @id 

				if @@ROWCOUNT = 0 
				RAISERROR('hi' , 16, 1 ) 
			else 
				
				commit transaction 
		END TRY 
		BEGIN CATCH 
			print ERROR_MESSAGE()
			rollback transaction 
		END CATCH 
end 

exec updateEmpName 6 , 'Naveen'
exec displayEmployees

