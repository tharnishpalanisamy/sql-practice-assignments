--Phase 3 – Joins (Important)
-- Clean up existing tables if resetting
DROP TABLE IF EXISTS Employee_Projects;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Projects;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Departments;

-- 1. Create Departments Table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

-- 2. Create Employees Table (Updated with DeptID and ManagerID)
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DepartmentID INT NULL, -- NULL allows testing "Employees without department"
    ManagerID INT NULL,    -- Self-referencing link for Manager
    Salary INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- 3. Create Projects Table
CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(50)
);

-- 4. Create Employee-Project Mapping (Many-to-Many Bridge Table)
CREATE TABLE Employee_Projects (
    EmployeeID INT,
    ProjectID INT,
    PRIMARY KEY (EmployeeID, ProjectID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID)
);

-- 5. Create E-Commerce Tables (Customers, Products, Orders)
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price DECIMAL(10,2)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- ==========================================
-- POPULATE DATA FOR TESTING JOIN PATTERNS
-- ==========================================

INSERT INTO Departments VALUES 
(10, 'HR'), (20, 'IT'), (30, 'Finance'), (40, 'Marketing'), (50, 'Empty Department');

-- Populating Employees with hierarchy (Managers & team members)
INSERT INTO Employees VALUES
(1, 'James', 'Bond', 20, NULL, 120000),  -- Top Manager for IT
(2, 'John', 'Doe', 20, 1, 60000),        -- Team member under James
(3, 'Jane', 'Smith', 20, 1, 75000),      -- Team member under James
(4, 'David', 'Wilson', 20, 1, 80000),    -- Team member under James (James now has 3)
(5, 'Robert', 'Jackson', 20, 1, 72000),  -- Team member under James (James now has 4!)
(6, 'Sarah', 'Martinez', 10, NULL, 56000),-- Manager for HR
(7, 'Ruth', 'Alpha', 10, 6, 54000),       -- Under Sarah
(8, 'Orphan', 'Worker', NULL, NULL, 45000);-- CRITICAL: Employee without department

INSERT INTO Projects VALUES 
(100, 'Project Alpha'), (200, 'Project Beta'), (300, 'Unassigned Project');

INSERT INTO Employee_Projects VALUES 
(2, 100), (3, 100), (3, 200), (4, 200);

INSERT INTO Customers VALUES 
(1, 'Alice'), (2, 'Bob'), (3, 'Charlie'); -- Charlie will have no orders

INSERT INTO Products VALUES 
(501, 'Laptop', 1200.00), (502, 'Mouse', 25.00), (503, 'Spaceship', 99999.00); -- Spaceship never sold

INSERT INTO Orders VALUES 
(9001, 1, 501, '2026-01-10'), (9002, 2, 502, '2026-02-15');

--You already practiced lots of joins. Revise only these.

--Q15

--Employee + Department
SELECT * FROM Employees e
JOIN Departments d
ON e.DepartmentID = d.DepartmentID

--Q16

--Employee + Department + Project

SELECT * FROM Employees e 
JOIN Departments d 
ON e.DepartmentID = d.DepartmentID 
JOIN Employee_Projects ep 
ON eP.EmployeeID = e.EmployeeID 
join Projects p 
ON p.ProjectID = ep.ProjectID

--Q17

--Employees without department

SELECT * FROM Employees e
LEFT JOIN Departments d
ON e.DepartmentID = d.DepartmentID 
WHERE e.DepartmentID IS NULL

--Q18

--Departments without employees
SELECT * 
FROM Departments d 
LEFT JOIN Employees e 
ON e.DepartmentID = d.DepartmentID  
WHERE e.EmployeeID IS NULL 


--Q19

--Customers without orders

SELECT * FROM Customers c 
LEFT JOIN Orders o 
ON c.CustomerID = o.CustomerID  
WHERE O.OrderID IS NULL 

--Q20

--Products never sold 

SELECT * FROM Products p 
LEFT JOIN Orders o 
ON p.ProductID = O.ProductID  
WHERE o.OrderID IS NULL 


--Q21

--Employee and Manager (Self Join)

SELECT E.EmployeeID , E.FirstName + ' ' + E.LastName AS NAME , E.DepartmentID  ,
E2.EmployeeID AS MANAGERID , E2.FirstName + ' ' + E2.LastName AS MANAGERNAME 
FROM Employees e 
JOIN Employees e2 
ON e.ManagerID = E2.EmployeeID ; 
--Q22

--Employees working in same department




SELECT E1.FirstName , E2.FirstName , E1.DepartmentID
FROM Employees E1
JOIN Employees E2 
ON E1.DepartmentID = E2.DepartmentID 
AND E1.EmployeeID < E2.EmployeeID ; 


--Q23

--Find managers having more than 3 team members
SELECT E2.FirstName AS MANAGERNAME , COUNT(E1.EmployeeID) AS EMPLOYEES
FROM Employees E1
JOIN Employees E2 
ON E1.ManagerID = E2.EmployeeID 
GROUP BY E2.FirstName 
HAVING COUNT(E1.EmployeeID) > 3 ; 
--These cover almost all join patterns.