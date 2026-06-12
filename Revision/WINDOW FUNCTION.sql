--Phase 6 – Window Functions

--Most important office topic.


-- 1. Drop existing tables if they exist
DROP TABLE IF EXISTS employee_sales;

-- 2. Create the practice table
CREATE TABLE employee_sales (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_name VARCHAR(50),
    salary DECIMAL(10,2),
    sales_amount DECIMAL(10,2)
);

-- 3. Insert targeted sample data
INSERT INTO employee_sales (emp_id, emp_name, dept_name, salary, sales_amount) VALUES 
-- Finance Department
(1, 'Alice',   'Finance', 150000.00, 5000.00),
(2, 'Bob',     'Finance', 95000.00,  3000.00),
(3, 'Charlie', 'Finance', 95000.00,  4500.00), -- Same salary as Bob to test ties

-- IT Department
(4, 'David',   'IT',      110000.00, 8000.00),
(5, 'Eva',     'IT',      90000.00,  6500.00),
(6, 'Frank',   'IT',      90000.00,  7000.00), -- Same salary as Eva
(7, 'Grace',   'IT',      75000.00,  2000.00),

-- HR Department
(8, 'Henry',   'HR',      70000.00,  1500.00),
(9, 'Ivy',     'HR',      60000.00,  2500.00);


--Q40

--Department average salary using OVER()

SELECT * , AVG(SALARY) OVER(PARTITION BY DEPT_ID ) AS AVGDEPTSALARY
FROM employees 

--Q41

--Running total of sales.
SELECT * ,SUM(sales_amount) OVER(ORDER BY EMP_ID) AS running_total_sales
FROM employee_sales 

--Q42

--Department maximum salary without GROUP BY.
SELECT * , MAX(sales_amount) OVER(PARTITION BY DEPT_NAME) AS MAXSALARY
FROM employee_sales

--Q43

--Salary difference from department maximum.
SELECT *  , MAX(sales_amount) OVER(PARTITION BY DEPT_NAME) - sales_amount AS DIFF 
FROM employee_sales 
--Q44

--Department-wise cumulative salary.

SELECT * , SUM(sales_amount) OVER(PARTITION BY DEPT_NAME ORDER BY EMP_ID) AS CUMULATIVE
FROM employee_sales 
ORDER BY dept_name

--Q45

--Percentage contribution within department. 
SELECT * , CAST(sales_amount AS FLOAT) * 100 /  SUM(sales_amount) OVER(PARTITION BY DEPT_NAME)  AS CONTRIBUTION 
FROM employee_sales