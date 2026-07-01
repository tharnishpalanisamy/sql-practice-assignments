--Phase 9 – Views

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
    DeptName VARCHAR(50),
    Location VARCHAR(50)
);

INSERT INTO Departments
VALUES
(1,'HR','Chennai'),
(2,'IT','Bangalore'),
(3,'Finance','Mumbai'),
(4,'Sales','Delhi');

-- ============================================
-- EMPLOYEES
-- ============================================

CREATE TABLE Employees
(
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    DeptID INT,
    Salary DECIMAL(10,2),
    Email VARCHAR(100),
    JoinDate DATE,
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);

INSERT INTO Employees
VALUES
(101,'Alice',1,50000,'alice@gmail.com','2021-01-10'),
(102,'Bob',2,85000,'bob@gmail.com','2020-03-15'),
(103,'Charlie',2,72000,'charlie@gmail.com','2022-06-11'),
(104,'David',3,91000,'david@gmail.com','2019-04-20'),
(105,'Eva',3,76000,'eva@gmail.com','2023-02-18'),
(106,'Frank',4,68000,'frank@gmail.com','2021-09-05'),
(107,'Grace',4,62000,'grace@gmail.com','2022-11-01');
--Q55

--Create simple view.

create view simpleView as 
select * from Employees 

select * from simpleView
--Q56

--Create join view.
create view summary as 
select e.EmpID , e.EmpName , e.Email , d.DeptID , d.DeptName
from Employees e 
join Departments d 
on e.DeptID = d.DeptID

select * from summary
--Q57

--Create complex view.
create view complexView as 
select * from Employees 
where Salary > (select max(salary) 
from Employees where DeptID = 1 )

select * from complexView
--Q58

--Update data through view.
insert into simpleView values (108 , 'Doe' , 1 , 150000 , 'Doe@gmail.com' , '2026-06-30') 
update simpleView set EmpName = 'John' where EmpName = 'Doe'
select * from simpleView
--Q59

--When is a view updatable?
--Yes view are updatable but not all views are updatable only simple view can be updated and views involving complex logic , 
-- group by  , joins or subquery cannot be updated 