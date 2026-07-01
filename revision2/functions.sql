--Phase 12 – Functions
--Scalar
--Q72

--Calculate bonus.

create function calculateBonus2 (
@salary decimal(10,2) ) 
returns decimal(10,2) 
as 
begin 
	declare @result decimal(10,2) 
	select @result = @salary * 0.1 
	return @result
end 

select * , dbo.calculateBonus2(salary) from Employees 



--Q73

--Calculate percentage. 
create function calculatePercentage2(
@salary decimal(10,2) , 
@bonus decimal(10,2) 
)
returns decimal(10,2) 
as 
begin 
	declare @result decimal(10,2) 
	select @result = @bonus * 100 / @salary 
	return @result 
end 

select * , dbo.CALCULATEPERCENTAGE2(salary ,dbo.calculateBonus2(salary) )  as percentage
from Employees 

--Table Valued
--Q74
--Return all employees in HR.
--Q75

create function displayHr () 
returns table 
return (
select * from Employees where Department = 'HR'
)

select * from dbo.displayHr()

--Return employees above average salary.

create function aboveAverageSalary() 
returns table 
as
return (
select * from Employees 
where Salary > (
select avg(salary) from Employees )
)

select * from aboveAverageSalary()

--Covered in your assignments.