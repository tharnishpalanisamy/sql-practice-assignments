--Phase 15 – Cursors

--Don't waste time doing many cursor problems.


CREATE TABLE Students (
    StudentID INT,
    StudentName VARCHAR(50),
    Marks INT,
    Grade CHAR(1)
);

INSERT INTO Students VALUES
(1,'Arun',95,NULL),
(2,'Priya',82,NULL),
(3,'Rahul',74,NULL),
(4,'Sneha',61,NULL),
(5,'John',48,NULL);

--Just revise:

--Q83

--Update grades using cursor.

--declare @grade char(1)
--declare @id int 
--declare @marks int 


--declare gradeCursor cursor for  
--select StudentID,  marks from Students 
--set nocount on 
----open 
--open gradeCursor  

--fetch next from gradeCursor into @id ,  @marks 

--while @@FETCH_STATUS = 0 
--begin 
--	set @grade = case when @marks > 90 then 'A' When @marks > 80 then 'A' 
--	else 'C' end 
--	update Students set Grade = @grade   where StudentID = @id   

--	print cast(@id as varchar(100)) + ' ' + cast(@marks as varchar(30)) +' ' + @grade 
	
--	fetch next from gradeCursor 
--	into @id , @marks 
--end 

--close gradeCursor 
--deallocate gradeCursor


--Q84

-- Drop table if exists
DROP TABLE IF EXISTS Employees;

-- Create Table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(50),
    Salary DECIMAL(10,2)
);

-- Insert Sample Data
INSERT INTO Employees VALUES
(101, 'Arun', 25000),
(102, 'Priya', 42000),
(103, 'Rahul', 58000),
(104, 'Sneha', 67000),
(105, 'John', 82000),
(106, 'David', 29500),
(107, 'Meena', 51000),
(108, 'Karthik', 76000);

-- View Data
SELECT * FROM Employees;

--Salary calculation using cursor.
declare @id int 
declare @salary decimal(10,2) 

declare salaryCursor cursor for 
select EmployeeID , Salary from Employees 

open salaryCursor 

fetch next from salaryCursor into @id , @salary 

while @@FETCH_STATUS = 0 
begin 
	print 'ID : ' + cast(@id as varchar(10)) +' ' + 'Old Salary : ' + 
	cast(@salary as varchar(10)) + ' New salary: ' +  cast(@salary * 1.1 as varchar(10)) 
	update Employees set salary = @salary * 1.1 where EmployeeID = @id ; 

	fetch next from salaryCursor into @id , @salary 
end 

close salaryCursor 
deallocate salaryCursor 

















