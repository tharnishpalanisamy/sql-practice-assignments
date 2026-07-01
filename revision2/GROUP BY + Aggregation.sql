--Phase 2 – GROUP BY + Aggregation

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
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    JoinDate DATE
);

-- ============================================
-- INSERT DATA
-- ============================================

INSERT INTO Employees (EmpID, EmpName, Department, Salary, JoinDate)
VALUES
(101,'Arun','HR',42000,'2021-02-10'),
(102,'Bala','IT',75000,'2020-08-15'),
(103,'Charan','Finance',68000,'2019-06-22'),
(104,'Divya','HR',52000,'2022-01-05'),
(105,'Esha','IT',85000,'2018-09-30'),
(106,'Farhan','Sales',47000,'2021-04-17'),
(107,'Gokul','Finance',73000,'2020-11-11'),
(108,'Harini','Sales',51000,'2019-12-08'),
(109,'Ishaan','IT',95000,'2017-05-21'),
(110,'Janani','HR',48000,'2023-03-01'),
(111,'Karthik','Finance',81000,'2018-07-19'),
(112,'Lakshmi','Sales',59000,'2020-10-25'),
(113,'Manoj','IT',67000,'2022-06-14'),
(114,'Nandhini','Marketing',62000,'2021-09-18'),
(115,'Om','Marketing',58000,'2019-01-10'),
(116,'Priya','Marketing',71000,'2023-02-11'),
(117,'Rahul','Sales',65000,'2018-08-28'),
(118,'Sneha','HR',56000,'2020-05-13'),
(119,'Tarun','Finance',92000,'2017-11-07'),
(120,'Vignesh','IT',78000,'2022-12-20');
--Aggregates


--Q9

--Department-wise employee count.

select Department , count(*) totalEmployees 
from Employees  
group by Department


--Q10

--Department-wise maximum salary.

select Department , max(salary) as maximumSalary
from Employees
group by Department

--Q11

--Departments whose average salary exceeds ₹50,000.

select Department , avg(salary) as averageSalary
from Employees
group by Department having AVG(salary) > 50000 

--Q12

--Display total salary and grand total using ROLLUP.
select ISNULL(Department , 'Grand Total') as department , 
sum(salary) as TotalSalary
from Employees
group by rollup(Department)

--Q13

--Display subtotal and grand total using CUBE.

select ISNULL(Department , 'Total') as department , sum(salary)  
from Employees
group by cube(Department)

--Q14

--Department-wise salary percentage contribution.
select Department , sum(salary) * 100 / (select sum(salary) from Employees )  as contribution
from Employees
group by Department


select distinct  Department , (sum(salary) over(partition by department) * 100 / sum(salary) over() ) as contribution
from Employees