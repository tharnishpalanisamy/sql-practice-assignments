--Phase 14 – MERGE

-- ============================================
-- Phase 14 – MERGE Practice
-- ============================================

-- DROP TABLES
DROP TABLE IF EXISTS CurrentEmployees;
DROP TABLE IF EXISTS MainEmployees;

-- ============================================
-- MAIN TABLE
-- ============================================

CREATE TABLE MainEmployees
(
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);

INSERT INTO MainEmployees VALUES
(101,'Arun','IT',65000),
(102,'Priya','HR',42000),
(103,'Karthik','Finance',72000),
(104,'Sneha','IT',58000),
(105,'Rahul','Sales',39000),
(106,'Divya','HR',45000);

-- ============================================
-- CURRENT TABLE
-- ============================================

CREATE TABLE CurrentEmployees
(
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);

INSERT INTO CurrentEmployees VALUES
(101,'Arun','IT',70000),          -- Salary changed (UPDATE)
(102,'Priya','HR',42000),         -- No change
(104,'Sneha','IT',60000),         -- Salary changed (UPDATE)
(106,'Divya','Human Resource',48000), -- Dept & Salary changed (UPDATE)
(107,'John','Sales',50000),       -- New employee (INSERT)
(108,'Naveen','Finance',75000);   -- New employee (INSERT)


--Q81

--Sync Main and Current tables.

merge MainEmployees as m
using CurrentEmployees as c
on m.empId = c.empId 

when matched then 
update set m.salary = c.salary 

when not matched by target 
then 
Insert (empId, empName ,department , salary ) 
values (c.empid , c.empname , c.department , c.salary) 

when not matched by source 
THEN
Delete ;


select * from MainEmployees 

select * from CurrentEmployees


--Q82
-- ============================================
-- MERGE Practice - Dataset 2
-- ============================================

-- DROP TABLES
DROP TABLE IF EXISTS CurrentProducts;
DROP TABLE IF EXISTS MainProducts;

-- ============================================
-- MAIN TABLE (Target)
-- ============================================

CREATE TABLE MainProducts
(
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Category VARCHAR(30),
    Price DECIMAL(10,2)
);

INSERT INTO MainProducts VALUES
(1,'Laptop','Electronics',65000),
(2,'Mouse','Accessories',800),
(3,'Keyboard','Accessories',1500),
(4,'Monitor','Electronics',12000),
(5,'Headphones','Accessories',2500),
(6,'Printer','Electronics',9000);

-- ============================================
-- CURRENT TABLE (Source)
-- ============================================

CREATE TABLE CurrentProducts
(
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Category VARCHAR(30),
    Price DECIMAL(10,2)
);

INSERT INTO CurrentProducts VALUES
(1,'Laptop','Electronics',67000),      -- UPDATE
(2,'Mouse','Accessories',800),         -- No Change
(4,'Monitor','Electronics',11500),     -- UPDATE
(6,'Printer','Electronics',9500),      -- UPDATE
(7,'Webcam','Accessories',3500),       -- INSERT
(8,'SSD','Storage',5000);              -- INSERT
--Handle:

--INSERT
--UPDATE
--DELETE

--using single MERGE statement.

MERGE MainProducts as m 
using  CurrentProducts as c 
on m.productId = c.productId 

when matched then 
update set price = c.price 

when not matched by target then 
insert (productId , productName , category , price ) values (c.productId , c.productName , c.category , c.price )

when not matched by source then 
delete ; 

select * from MainProducts 
select * from CurrentProducts




