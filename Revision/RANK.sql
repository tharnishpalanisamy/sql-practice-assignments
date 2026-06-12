--Phase 7 – Ranking Functions

-- 1. Drop existing table if it exists
DROP TABLE IF EXISTS employee_ranks;

-- 2. Create the practice table
CREATE TABLE employee_ranks (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_name VARCHAR(50),
    salary DECIMAL(10,2)
);

-- 3. Insert targeted sample data
INSERT INTO employee_ranks (emp_id, emp_name, dept_name, salary) VALUES 
-- IT Department (Has a tie at 90k, and a clear top/bottom)
(1, 'Alice',   'IT', 110000.00), -- Top 1
(2, 'Bob',     'IT', 90000.00),  -- Tie for 2nd
(3, 'Charlie', 'IT', 90000.00),  -- Tie for 2nd
(4, 'David',   'IT', 75000.00),  -- Bottom

-- HR Department (Has a tie at the very top)
(5, 'Eva',     'HR', 95000.00),  -- Joint Top 1
(6, 'Frank',   'HR', 95000.00),  -- Joint Top 1
(7, 'Grace',   'HR', 60000.00),  -- Bottom

-- Finance Department (Straight progression)
(8, 'Henry',   'Finance', 120000.00),
(9, 'Ivy',     'Finance', 100000.00),
(10, 'Jack',   'Finance', 80000.00);

--Q46

--Apply ROW_NUMBER()

SELECT * , ROW_NUMBER() OVER(ORDER BY EMP_ID) AS ROWNUMBER
FROM employee_ranks

--Q47

--Apply RANK()

SELECT * , RANK() OVER(ORDER BY SALARY DESC) AS HIGHESTPAID 
FROM employee_ranks 
ORDER BY SALARY DESC

--Q48

--Apply DENSE_RANK()

SELECT * , DENSE_RANK() OVER(ORDER BY SALARY DESC)  AS DENSERANK
FROM employee_ranks 


--Q49

--Find top 2 salaries in each department.
WITH CTE AS 
(
SELECT * , DENSE_RANK() OVER( PARTITION BY DEPT_NAME ORDER BY SALARY DESC ) AS RANK
FROM employee_ranks)
SELECT * FROM CTE WHERE RANK <= 2 ; 

--Q50

--Find bottom 3 salaries in each department.
WITH CTE AS 
(SELECT *  , DENSE_RANK() OVER(PARTITION BY DEPT_NAME ORDER BY SALARY ) RANK
FROM employee_ranks) 
SELECT * FROM CTE WHERE RANK <= 3 ; 