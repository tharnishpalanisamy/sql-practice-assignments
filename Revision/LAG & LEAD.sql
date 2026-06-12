--Phase 8 – LAG / LEAD

-- 1. Drop existing tables if they exist
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS employee_analytics;

-- 2. Create the Employee table (For Q51 & Q52)
CREATE TABLE employee_analytics (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_name VARCHAR(50),
    salary DECIMAL(10,2),
    sales_amount DECIMAL(10,2)
);

-- 3. Create the Orders table (For Q53 & Q54)
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_amount DECIMAL(10,2)
);

-- 4. Insert data for Employee Analytics
INSERT INTO employee_analytics (emp_id, emp_name, dept_name, salary, sales_amount) VALUES 
(1, 'Alice',   'Finance', 150000.00, 5000.00),
(2, 'Bob',     'Finance',  95000.00, 3000.00),
(3, 'Charlie', 'Finance',  90000.00, 4500.00),
(4, 'David',   'IT',      110000.00, 8000.00),
(5, 'Eva',     'IT',       90000.00, 6500.00);

-- 5. Insert data for Orders
INSERT INTO orders (order_id, customer_id, order_date, order_amount) VALUES 
(101, 1001, '2026-01-01', 250.00),
(102, 1001, '2026-01-05', 400.00), -- 4 days gap
(103, 1001, '2026-01-15', 150.00), -- 10 days gap
(104, 1002, '2026-01-02', 600.00),
(105, 1002, '2026-01-03', 800.00); -- 1 day gap

--Q51

--Compare current sale with previous sale.
SELECT * , LAG(sales_amount) OVER(ORDER BY emp_id) , sales_amount - LAG(sales_amount) OVER(ORDER BY EMP_ID) AS DIFFERENCE
FROM employee_analytics


--Q52

--Find salary growth compared with previous employee.

SELECT * , LAG(salary) OVER(ORDER BY EMP_ID) - salary AS GROWTH 
FROM employee_analytics

--Q53

--Find days gap between orders.

SELECT * , DATEDIFF(DAY,LAG(order_date) OVER(PARTITION BY CUSTOMER_ID ORDER BY ORDER_ID) , order_date) 
FROM orders 

--Q54

--Display next order amount.

SELECT * , LEAD(order_amount) OVER(ORDER BY ORDER_ID)
FROM orders

--These are directly from your window-function assignment.