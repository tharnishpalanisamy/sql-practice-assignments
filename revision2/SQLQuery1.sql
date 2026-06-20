CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(50),
    Email VARCHAR(100),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    JoinDate DATE
);
INSERT INTO Employees VALUES
(1, 'Arun',     'arun@gmail.com',     'IT',      50000, '2025-01-10'),
(2, 'Aashwin',  'aashwin@gmail.com',  'IT',      70000, '2025-12-15'),
(3, 'Karthik',  'karthik@gmail.com',  'IT',      60000, '2024-11-20'),
(4, 'Aman',     'aman@gmail.com',     'IT',      80000, '2026-03-05'),
(5, 'John',     'john@gmail.com',     'IT',      75000, '2025-08-01'),
(6, 'Mohan',    'mohan@gmail.com',    'HR',      65000, '2026-02-18'),
(7, 'Rohan',    'rohan@gmail.com',    'IT',      90000, '2025-06-10'),
(8, 'Saran',    'duplicate@gmail.com','Finance', 90000, '2026-01-01'),
(9, 'Vignesh',  'duplicate@gmail.com','IT',      55000, '2024-09-15'),
(10,'Ajayan',   'ajayan@gmail.com',   'IT',      90000, '2026-04-12');




--Phase 1 – Core Querying (Must Be Instant)
--Filtering & Sorting
--Q1

--Retrieve employees whose salary is greater than the average salary.
select * from employees
where Salary > (
select avg(salary) from employees)

--Q2

--Retrieve employees whose name starts with A and ends with n.
select * from Employees 
where EmployeeName like 'A%n' 

--Q3

--Find employees who joined in the last 6 months.
select * from Employees 
where DATEDIFF(MONTH , joinDate , GETDATE()) < 6 ; 

--Q4

--Display top 3 highest-paid employees with ties.
select TOP(3) with ties * 
from Employees order by Salary desc

--Q5

--Retrieve duplicate email records.
select Email, count(Email)  from Employees 
group by Email having count(email) > 1 

--Q6

--Retrieve departments having more than 5 employees.

select department , count(EmployeeName)
from Employees 
group by department having count(EmployeeName) > 5 

--Q7

--Display the second highest salary.
select * from Employees
order by Salary desc 
offset 1 rows 
fetch next 1 rows only

--Q8

--Display the nth highest salary.

DECLARE @n int = 4 ; 
declare @skip int = @n-1
select * from Employees 
order by Salary desc 
offset @skip rows 
fetch next 1 rows only