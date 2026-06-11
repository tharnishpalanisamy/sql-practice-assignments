



CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary INT,
    HireDate DATE
);

INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, Salary, HireDate) VALUES
(1, 'John', 'Doe', 'HR', 55000, '2020-01-15'),
(2, 'Jane', 'Smith', 'IT', 75000, '2019-03-20'),
(3, 'Michael', 'Brown', 'Finance', 85000, '2018-07-12'),
(4, 'Emily', 'Davis', 'Marketing', 62000, '2021-11-05'),
(5, 'David', 'Wilson', 'IT', 78000, '2020-02-18'),
(6, 'Sarah', 'Martinez', 'HR', 56000, '2022-05-14'),
(7, 'James', 'Anderson', 'Finance', 90000, '2017-09-01'),
(8, 'Amanda', 'Thomas', 'Marketing', 64000, '2021-03-25'),
(9, 'Robert', 'Jackson', 'IT', 72000, '2022-10-10'),
(10, 'Lisa', 'White', 'Sales', 58000, '2019-06-18'),
(11, 'William', 'Harris', 'Sales', 60000, '2020-08-22'),
(12, 'Mary', 'Martin', 'Engineering', 95000, '2016-04-11'),
(13, 'Danny', 'Garcia', 'Engineering', 92000, '2021-01-29'),
(14, 'Ruth', 'Martinez', 'HR', 54000, '2023-02-10'),
(15, 'Kevin', 'Robinson', 'Finance', 87000, '2018-11-30'),
(16, 'Haley', 'Clark', 'Marketing', 61000, '2022-07-15'),
(17, 'Mark', 'Rodriguez', 'IT', 80000, '2019-12-05'),
(18, 'Michelle', 'Lewis', 'Sales', 59000, '2021-04-12'),
(19, 'Andrew', 'Lee', 'Engineering', 98000, '2015-05-20'),
(20, 'Ashley', 'Walker', 'Legal', 105000, '2017-01-10');



--Phase 2 – GROUP BY + Aggregation
--Aggregates
--Q9

--Department-wise employee count.
SELECT Department , COUNT(EmployeeID) AS EMPCOUNT
FROM Employees 
GROUP BY Department 

--Q10

--Department-wise maximum salary.
SELECT DEPARTMENT , MAX(Salary) AS MAXSALARY
FROM Employees 
GROUP BY Department 

--Q11

--Departments whose average salary exceeds ₹50,000.

SELECT Department , AVG(Salary) AS AVERAGESALARY
FROM Employees 
GROUP BY Department 
HAVING AVG(Salary) > 70000 ; 

--Q12

--Display total salary and grand total using ROLLUP.

SELECT ISNULL(Department , 'GRAND TOTAL' ) AS DEPARTMENT, SUM(Salary) AS TOTALSALARY
FROM Employees
GROUP BY ROLLUP(Department) 
--Q13

--Display subtotal and grand total using CUBE.
SELECT ISNULL(Department , 'GRAND TOTAL') AS DEPARTMENT , SUM(Salary)
FROM Employees 
GROUP BY CUBE(Department) 


--Q14

--Department-wise salary percentage contribution. 


SELECT Department , ROUND( CAST(SUM(SALARY) AS FLOAT )  / SUM(SUM(SALARY)) OVER() * 100 ,2)  AS CONTRIBUTION
FROM Employees
GROUP BY Department































