--Phase 4 – Subqueries

--You have an entire assignment dedicated to this. Revise only these patterns.



DROP TABLE IF EXISTS Employee_Projects;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Projects;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Departments;






-- 1. Create Tables
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(50),
    emp_id INT,
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

-- 2. Insert Sample Data
INSERT INTO departments VALUES 
(10, 'Finance'),
(20, 'IT'),
(30, 'HR'),
(40, 'Marketing'); -- Empty department for testing

INSERT INTO employees VALUES 
(1, 'Alice', 90000, 10),
(2, 'Bob', 60000, 10),
(3, 'Charlie', 110000, 20),
(4, 'David', 80000, 20),
(5, 'Eva', 50000, 30);

INSERT INTO projects VALUES 
(101, 'Audit', 1),
(102, 'Cloud Migration', 3),
(103, 'Security', 3);



--Single Row
--Q24

--Employees earning above average salary. 

SELECT * FROM employees 
WHERE salary > (
SELECT AVG(Salary) FROM employees )

--Q25

--Employees earning more than department average.
SELECT * FROM employees E1
WHERE salary > 
(SELECT AVG(SALARY) FROM employees E2 
WHERE E1.DEPT_ID = E2.DEPT_ID 
)

--Multi Row
--Q26

--Employees working in departments returned by another query.
SELECT * FROM employees 
WHERE dept_id IN (
SELECT dept_id FROM departments  )
--Q27
SELECT * FROM departments
--Salary > ALL Finance employees.
SELECT * FROM employees 
WHERE salary > ALL (
SELECT salary FROM employees 
WHERE dept_id = 10 
)

--Q28

--Salary > ANY IT employee.

SELECT * FROM employees
WHERE salary > ANY (
SELECT salary FROM employees E 
JOIN departments D 
ON E.dept_id = D.dept_id 
WHERE D.dept_name = 'IT'
)

--EXISTS
--Q29

--Departments that have employees. 

select * from departments d 
WHERE EXISTS (
SELECT 1 FROM employees E 
WHERE E.dept_id = D.dept_id )

--Q30

--Employees who have projects.
SELECT * FROM employees E 
WHERE EXISTS (
SELECT 1 FROM projects P 
WHERE E.emp_id = P.emp_id )
--Q31

--Employees who do not have projects.
SELECT * FROM employees E 
WHERE NOT EXISTS (
SELECT 1 FROM projects P 
WHERE E.emp_id = P.emp_id )


--Correlated
--Q32

--Highest salary employee in every department.
SELECT * FROM employees E 
WHERE salary = 
(
SELECT MAX(SALARY) FROM employees E2 
WHERE E.dept_id = E2.dept_id  )


--Q33

--Employees earning above their department average.

SELECT * FROM employees E 
WHERE salary > (
SELECT AVG(SALARY) FROM employees E2 
WHERE E.dept_id = E2.dept_id)