--Phase 4 – Subqueries

-- ============================================
-- DROP TABLES
-- ============================================

DROP TABLE IF EXISTS ProjectAssignments;
DROP TABLE IF EXISTS Projects;
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
(4,'Marketing'),
(5,'Sales');

-- ============================================
-- EMPLOYEES
-- ============================================

CREATE TABLE Employees
(
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    DeptID INT,
    Salary DECIMAL(10,2)
);

INSERT INTO Employees VALUES
(101,'Alice',2,90000),
(102,'Bob',2,70000),
(103,'Charlie',2,60000),
(104,'David',3,95000),
(105,'Eva',3,85000),
(106,'Frank',3,65000),
(107,'Grace',1,50000),
(108,'Henry',1,45000),
(109,'Ivy',4,80000),
(110,'Jack',4,75000),
(111,'Kevin',5,55000),
(112,'Linda',5,50000);

-- ============================================
-- PROJECTS
-- ============================================

CREATE TABLE Projects
(
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(50)
);

INSERT INTO Projects VALUES
(1,'Payroll System'),
(2,'Inventory System'),
(3,'Website'),
(4,'Mobile App');

-- ============================================
-- PROJECT ASSIGNMENTS
-- ============================================

CREATE TABLE ProjectAssignments
(
    EmpID INT,
    ProjectID INT,
    PRIMARY KEY(EmpID, ProjectID)
);

INSERT INTO ProjectAssignments VALUES
(101,1),
(101,2),
(102,2),
(104,3),
(105,1),
(107,4),
(109,3),
(111,2);

--You have an entire assignment dedicated to this. Revise only these patterns.

--Single Row
--Q24

--Employees earning above average salary.

select * from Employees 
where Salary > (
select avg(salary) from employees )
--Q25

--Employees earning more than department average.

select * from 
Employees e1
where e1.Salary > (
select AVG(salary) from Employees e2
where e2.DeptID = e1.DeptID 
group by e2.DeptID
)



--Multi Row
--Q26

--Employees working in departments returned by another query.
select * from Employees e1 
where e1.DeptID in (
select e2.DeptID 
from Employees e2 )

--Q27

--Salary > ALL IT employees.

select * from Employees e1 
where e1.Salary > (
select max(Salary) from Employees 
where DeptID = 2
)

--Q28

--Salary > ANY IT employee.
select * from Employees 
where Salary > any (
select Salary from Employees 
where DeptID = 2
)


--EXISTS
--Q29

--Departments that have employees.
select * from Departments d
where exists (select 1 from Employees e
where e.DeptID = d.DeptID )

--Q30

--Employees who have projects.
select * from Employees e
where exists(select 1 from ProjectAssignments pa 
where e.EmpID = pa.EmpID )
--Q31

--Employees who do not have projects.
select * from Employees e
where not exists(select 1 from ProjectAssignments pa 
where e.EmpID = pa.EmpID )

--Correlated
--Q32

--Highest salary employee in every department.
select * from Employees e1 
where Salary = (
select max(Salary) from Employees e2 
where e1.DeptID = e2.DeptID 
)


--Q33

--Employees earning above their department average.

select * from Employees e1 
where e1.Salary > (
select avg(Salary) from Employees e2  
where e1.DeptID = e2.DeptID
)
