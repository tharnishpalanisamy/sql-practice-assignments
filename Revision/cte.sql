



--Phase 5 – CTE

--Your assignment already covers most important CTE patterns.


-- 1. Drop existing tables if they exist
DROP TABLE IF EXISTS projects;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

-- 2. Create Tables
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2),
    dept_id INT,
    manager_id INT, -- Added for recursive hierarchy
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id),
    FOREIGN KEY (manager_id) REFERENCES employees(emp_id)
);

-- 3. Insert Sample Data
INSERT INTO departments VALUES 
(10, 'Finance'),
(20, 'IT'),
(30, 'HR');

INSERT INTO employees VALUES 
-- Executive Management
(1, 'Alice', 150000.00, 10, NULL), -- Top Boss

-- IT Department
(3, 'Charlie', 110000.00, 20, 1),  -- IT Lead
(4, 'David', 90000.00, 20, 3),    -- IT Dev 1
(6, 'Frank', 90000.00, 20, 3),    -- IT Dev 2 (Same salary to test rank ties)
(7, 'Grace', 75000.00, 20, 3),    -- IT Junior

-- Finance Department
(2, 'Bob', 95000.00, 10, 1),      -- Finance Senior

-- HR Department
(5, 'Eva', 60000.00, 30, 1);       -- HR Generalist



--Q34

--Employees earning above company average.

WITH CTE AS 
(
SELECT * FROM employees 
WHERE SALARY > (
SELECT AVG(SALARY) FROM employees)
)
SELECT * FROM CTE

--Q35

--Department-wise total salary.

WITH CTE1 AS 
(
SELECT dept_id , sum(salary) as total FROM employees 
group by dept_id ) 
select * from CTE1

--Q36

--Second highest salary per department.

WITH cte AS (
SELECT dept_id , salary , DENSE_RANK() OVER(PARTITION BY dept_id ORDER BY SALARY DESC  ) AS SECONDSALARY
FROM employees) 
SELECT dept_id , salary 
FROM cte 
WHERE SECONDSALARY = 2 




SELECT * FROM employees ORDER BY salary DESC OFFSET 1 ROWS FETCH NEXT 1 ROWS ONLY
--Q37

--Top 3 highest-paid employees.

WITH CTE AS (
SELECT TOP(3) * FROM employees 
ORDER BY salary DESC ) 
SELECT * FROM CTE 

--Q38

--Recursive employee-manager hierarchy.
WITH ORGLEVEL AS 
(
SELECT emp_id , emp_name , manager_id , 1 AS LEVEL 
FROM employees 
WHERE manager_id IS NULL     

UNION ALL 

SELECT E.emp_id , E.emp_name , E.manager_id , o.LEVEL + 1 AS LEVEL 
FROM employees E 
JOIN ORGLEVEL O 
ON E.manager_id = O.emp_id  


)
SELECT * FROM ORGLEVEL 
ORDER BY LEVEL , manager_id 


--Q39

--Multiple CTE:

--department avg salary
--employees above avg

WITH DEPT AS (
SELECT dept_id , AVG(SALARY) AS AVGSALARY 
FROM employees 
GROUP BY dept_id ) 
SELECT *
FROM employees E 
JOIN DEPT D 
ON D.dept_id = E.dept_id 
WHERE E.salary > D.AVGSALARY