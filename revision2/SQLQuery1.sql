--Phase 1 – Core Querying (Must Be Instant)

-- ============================================
-- DROP TABLE
-- ============================================

DROP TABLE IF EXISTS Employees;
-- ============================================
-- CREATE TABLE
-- ============================================

CREATE TABLE Employees
(
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Email VARCHAR(100),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    JoinDate DATE
);

-- ============================================
-- INSERT DATA
-- ============================================

INSERT INTO Employees VALUES
(101,'Arun','arun@gmail.com','HR',45000,'2026-01-10'),
(102,'Ajithan','ajith@gmail.com','IT',70000,'2026-05-15'),
(103,'Bala','bala@gmail.com','IT',65000,'2025-09-20'),
(104,'Charan','charan@gmail.com','Finance',55000,'2026-03-12'),
(105,'David','david@gmail.com','HR',48000,'2025-11-18'),
(106,'Eshan','eshan@gmail.com','IT',85000,'2024-12-01'),
(107,'Farhan','farhan@gmail.com','Finance',72000,'2026-02-25'),
(108,'Gokul','gokul@gmail.com','IT',62000,'2025-08-10'),
(109,'Hari','hari@gmail.com','IT',90000,'2025-12-15'),
(110,'Imran','imran@gmail.com','HR',45000,'2026-06-01'),
(111,'Jeevan','jeevan@gmail.com','Finance',76000,'2026-04-18'),
(112,'Karan','karan@gmail.com','IT',90000,'2026-01-22'),
(113,'Lokesh','lokesh@gmail.com','IT',51000,'2025-10-05'),
(114,'Mohan','mohan@gmail.com','Finance',58000,'2026-05-08'),
(115,'Naveen','naveen@gmail.com','IT',67000,'2025-07-17'),
(116,'Arun','arun@gmail.com','HR',47000,'2026-03-01'),
(117,'Ashwin','ashwin@gmail.com','IT',82000,'2026-02-14'),
(118,'Praveen','praveen@gmail.com','IT',70000,'2025-12-20'),
(119,'Rohan','rohan@gmail.com','IT',65000,'2026-01-30'),
(120,'Sachin','sachin@gmail.com','Finance',54000,'2025-11-01');

--Filtering & Sorting
--Q1

--Retrieve employees whose salary is greater than the average salary.

select * from Employees 
where Salary > (select avg(salary) from Employees) 


--Q2

--Retrieve employees whose name starts with A and ends with n.

select * from Employees 
where EmpName like 'A%n' 

--Q3

--Find employees who joined in the last 6 months.

select * from Employees 
where JoinDate >= DATEADD(month , -6 , GETDATE()) 
 
--Q4

--Display top 3 highest-paid employees with ties.

select top 3 with ties * 
from Employees 
order by Salary desc

--Q5

--Retrieve duplicate email records.

select * 
from Employees 
where Email in (
select email from 
Employees 
group by email having count(*) > 1
)
--Q6

--Retrieve departments having more than 5 employees.

select Department 
from Employees
group by Department having count(*) > 5

--Q7

--Display the second highest salary.
select distinct * from Employees 
order by salary desc
offset 1 rows 
fetch next 1 rows only 


--Q8

--Display the nth highest salary.

declare @n int = 4 
declare @skip int = @n - 1 

select distinct * from Employees 
order by Salary desc 
offset @skip rows 
fetch next 1 rows only