--Phase 5 – CTE


-- ============================================
-- DROP TABLES
-- ============================================

DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Departments;

-- ============================================
-- DEPARTMENTS
-- ============================================

CREATE TABLE Departments
(
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50)
);

INSERT INTO Departments VALUES
(1,'HR'),
(2,'IT'),
(3,'Finance'),
(4,'Sales'),
(5,'Marketing');

-- ============================================
-- EMPLOYEES
-- ============================================

CREATE TABLE Employees
(
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    DeptID INT,
    Salary DECIMAL(10,2),
    ManagerID INT NULL,
    SalesAmount DECIMAL(10,2),
    JoinDate DATE,
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID),
    FOREIGN KEY (ManagerID) REFERENCES Employees(EmpID)
);

INSERT INTO Employees
(EmpID, EmpName, DeptID, Salary, ManagerID, SalesAmount, JoinDate)
VALUES
(101,'Alice',1,50000,NULL,0,'2018-01-10'),

(102,'Bob',2,90000,101,120000,'2019-03-15'),
(103,'Charlie',2,75000,102,90000,'2020-07-20'),
(104,'David',2,68000,102,85000,'2021-02-18'),

(105,'Eva',3,95000,101,0,'2018-11-01'),
(106,'Frank',3,82000,105,0,'2020-04-12'),
(107,'Grace',3,76000,105,0,'2022-01-17'),

(108,'Henry',4,70000,101,250000,'2019-05-09'),
(109,'Ivy',4,65000,108,200000,'2020-09-23'),
(110,'Jack',4,60000,108,180000,'2021-06-05'),
(111,'Kevin',4,55000,108,170000,'2022-03-30'),

(112,'Lily',5,72000,101,0,'2019-08-14'),
(113,'Mike',5,68000,112,0,'2020-10-11'),
(114,'Nancy',5,64000,112,0,'2021-12-01'),
(115,'Oscar',5,58000,112,0,'2023-02-08');
--Your assignment already covers most important CTE patterns.

--Q34

--Employees earning above company average.

with aboveAverage as (
select * from Employees e1 
where Salary > (
select avg(salary) from Employees )
)select * from aboveAverage




--Q35

--Department-wise total salary.
with deptwiseTotal as (
select DeptID , sum(Salary) as total
from Employees
group by DeptID
)
select * from deptwiseTotal

--Q36

--Second highest salary per department.

with secondHighest as (
select deptId , max(salary) as secondHighest
from Employees e1
where salary < (select max(salary) from Employees e2 where e1.deptId = e2.deptId)
group by DeptID ) select * from secondHighest



--Q37

--Top 3 highest-paid employees.

with top3 as (
select top 3 * 
from Employees 
order by Salary desc)select * from top3 

--Q38

--Recursive employee-manager hierarchy.

WITH EmployeeHierarchy AS
(
    SELECT EmpID,
           EmpName,
           ManagerID,
           1 AS Level
    FROM Employees
    WHERE ManagerID IS NULL

    UNION ALL

    SELECT e.EmpID,
           e.EmpName,
           e.ManagerID,
           eh.Level + 1
    FROM Employees e
    JOIN EmployeeHierarchy eh
    ON e.ManagerID = eh.EmpID
)

SELECT
    h.EmpID,
    h.EmpName,
    m.EmpName AS ManagerName,
    h.Level
FROM EmployeeHierarchy h
LEFT JOIN Employees m
ON h.ManagerID = m.EmpID;


--Q39

--Multiple CTE:

--department avg salary
with deptAvg as 
(
select DeptID , avg(salary) as average
from Employees 
group by DeptID) select * from deptAvg

--employees above avg

with aboveAvgSary as (
select * from Employees 
where Salary > (
select avg(salary) from Employees)
)select * from aboveAvgSary 










