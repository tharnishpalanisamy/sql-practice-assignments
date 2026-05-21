CREATE TABLE Employees
(
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    JoiningDate DATE,
    ManagerID INT
);

INSERT INTO Employees VALUES
(101, 'Arun', 'HR', 45000, '2021-01-10', NULL),
(102, 'Bala', 'HR', 52000, '2021-03-15', 101),
(103, 'Charan', 'IT', 70000, '2020-07-11', 105),
(104, 'Deepak', 'IT', 72000, '2019-08-21', 105),
(105, 'Elan', 'IT', 95000, '2018-04-05', NULL),
(106, 'Farooq', 'Sales', 50000, '2022-01-17', 108),
(107, 'Gokul', 'Sales', 55000, '2021-11-01', 108),
(108, 'Hari', 'Sales', 85000, '2017-09-13', NULL),
(109, 'Indhu', 'Finance', 65000, '2020-06-10', 110),
(110, 'Jeeva', 'Finance', 90000, '2016-02-25', NULL);



CREATE TABLE Sales
(
    SaleID INT PRIMARY KEY,
    SalesPerson VARCHAR(100),
    Region VARCHAR(50),
    SaleDate DATE,
    Amount DECIMAL(10,2)
);
INSERT INTO Sales VALUES
(1, 'Arun', 'South', '2025-01-01', 1000),
(2, 'Arun', 'South', '2025-01-03', 1500),
(3, 'Arun', 'South', '2025-01-05', 2500),
(4, 'Bala', 'North', '2025-01-01', 2000),
(5, 'Bala', 'North', '2025-01-04', 3000),
(6, 'Charan', 'East', '2025-01-02', 1800),
(7, 'Charan', 'East', '2025-01-06', 2200),
(8, 'Deepak', 'West', '2025-01-03', 2700),
(9, 'Deepak', 'West', '2025-01-07', 3200),
(10, 'Elan', 'South', '2025-01-08', 4000);



--A. SINGLE CTE TASKS
--Medium Level
--Q1 - Write a CTE to display employees earning more than the company average salary.

with moreThanAvg as (
select EmployeeID , EmployeeName , Salary from Employees 
where Salary > (
select avg(salary) from Employees )
)
select * from moreThanAvg



--Q2 - Write a CTE to find departments having more than 2 employees.

with moreThanTwo as (
select Department , count(*) as count from Employees 
group by Department having count(*) > 3 
)
select * from moreThanTwo

--Q3 - Using CTE, display employees joined after 2020 with salary greater than 50000.

WITH joinedAfter20 as (
select EmployeeID , EmployeeName,Salary , JoiningDate  from Employees  
where YEAR(JoiningDate) > 2020 and Salary > 50000
)
select * from joinedAfter20


select * from Employees
--Q4 - Write a CTE to calculate total salary department-wise.
--Advanced Level

with deptWiseSalary as (
select Department , sum(Salary) as DeptWiseSalary FROM Employees 
group by Department
)
select * from deptWiseSalary

--Q5 - Using a CTE, find the second highest salary in each department.

WITH secondHighestSalary as (
select distinct(salary) as SecondHighestSalary from Employees
order by Salary desc 
offset 1 rows 
fetch next 1 rows only
)
select * from secondHighestSalary

select * from Employees

--Q6 - Write a CTE to identify employees whose salary is greater than their department average.

WITH moreThanAvg as (

select * from Employees e1 where Salary > (
select avg(salary) from Employees e2 where e1.Department = e2.Department
) 
)
select * from moreThanAvg

select avg(salary) from Employees e2 group by Department


--Q7 - Using CTE, display top 3 highest paid employees in the company.

WITH RankedEmployees as (
SELECT * , ROW_NUMBER() OVER(order by salary) as rn from Employees  
)
select * from RankedEmployees where rn <= 3 


--Q8 - Write a recursive CTE to display employee-manager hierarchy.

--B. MULTIPLE CTE TASKS
--Medium Level
--Q9 - Create two CTEs:
--•	First CTE → department-wise average salary 
--•	Second CTE → employees above department average 
--Display final result.

With recursiveCte as (
select EmployeeID, EmployeeName , Salary , ManagerID , 1 as LEVEL 
from Employees 
Where ManagerID is NULL 

UNION ALL

select e.EmployeeID , e.EmployeeName , e.Salary , e.ManagerID , rc.LEVEL + 1
from Employees e join recursiveCte rc on e.ManagerID = rc.EmployeeID 
)
select * from recursiveCte


--Q10 - Create multiple CTEs to:
--•	Calculate total sales per salesperson 
--•	Rank salespersons based on total sales 

WITH totalSale as (
select SalesPerson,sum(Amount)as totalSale from Sales  group by SalesPerson 
) , rankSale as (
select * , DENSE_RANK() OVER(ORDER by totalSale desc) as rank from totalSale
)
select * from rankSale

select * from Sales
--Advanced Level
--Q11 - Using multiple CTEs:
--•	Find monthly sales totals 
--•	Find region-wise highest monthly sale 
--Q12 - Using multiple CTEs, identify employees whose salary growth compared to department average exceeds 20%.

--C. OVER(PARTITION BY) TASKS
--Medium Level
--Q13 - Display employee salary along with department-wise average salary using OVER(PARTITION BY).
--Q14 - Display running total of sales amount salesperson-wise.
--Q15 - Display highest salary in each department without GROUP BY.
--Advanced Level
--Q16 - Display salary difference between employee salary and department maximum salary.
--Q17 - Find cumulative sales percentage contribution of each salesperson within their region.

--D. FIRST_VALUE() TASKS
--Medium Level
--Q18 - Display first sale amount for each salesperson.
--Q19 - Display earliest joined employee in each department using FIRST_VALUE().
--Advanced Level
--Q20 - Compare each employee salary with first hired employee salary in department.

--E. LAST_VALUE() TASKS
--Medium Level
--Q21 - Display latest sale amount for each salesperson using LAST_VALUE().
--Q22 - Display last joined employee in each department.
--Advanced Level
--Q23 - Compare employee salary with latest joined employee salary in department.


--F. RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
--Medium Level
--Q24 - Display total sales amount for entire salesperson partition using RANGE clause.
--Q25 - Display department total salary for every employee row using RANGE clause.
--Advanced Level
--Q26 - Display percentage contribution of each sale to total salesperson sales using RANGE BETWEEN.
--Q27 - Find employee salary contribution percentage within department.

--G. LAG() TASKS
--Medium Level
--Q28 - Display previous sale amount for each salesperson using LAG().
--Q29 - Display previous employee salary within department ordered by joining date.
--Advanced Level
--Q30 - Find salary increase compared to previous joined employee within department.
--Q31 - Identify days where sales increased compared to previous sale date.

--H. LEAD() TASKS
--Medium Level
--Q32 - Display next sale amount for each salesperson.
--Q33 - Display next employee joining date within department.
--Advanced Level
--Q34 - Calculate future sales difference using LEAD().
--Q35 - Find employees whose next employee salary differs by more than 10000.

--I. RANK() TASKS
--Medium Level
--Q36 - Rank employees based on salary department-wise.
--Q37 - Rank salespersons based on total sales.


--Advanced Level
--Q38 - Find top 2 salaried employees in each department using RANK().
--Q39 - Find lowest ranked salesperson in each region.

--J. DENSE_RANK() TASKS
--Medium Level
--Q40 - Apply DENSE_RANK() on employee salaries department-wise.
--Q41 - Find dense ranking of salespersons by region.
--Advanced Level 
--Q42 - Find second highest salary in each department using DENSE_RANK().
--Q43 - Identify top 3 unique salaries across company using DENSE_RANK().

