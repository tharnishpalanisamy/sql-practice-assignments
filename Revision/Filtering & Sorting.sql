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


--Filtering & Sorting
--Q1

--Retrieve employees whose salary is greater than the average salary.
SELECT AVG(Salary) AS AverageSalary FROM Employees
SELECT * FROM Employees 
WHERE Salary > 
(SELECT AVG(Salary) FROM Employees ) 

--Q2

--Retrieve employees whose name starts with A and ends with n.

SELECT * FROM Employees 
WHERE FirstName like 'A%a'

--Q3

--Find employees who joined in the last 6 months.

SELECT * FROM Employees 
WHERE HireDate >= DATEADD(YEAR , -6 , GETDATE())  ; 

--Q4

--Display top 3 highest-paid employees with ties.

SELECT TOP(3) WITH TIES * 
FROM Employees ORDER BY Salary DESC 

--Q5

--Retrieve duplicate email records.

alter table Employees add email varchar(50) ; 
update Employees set email = 'sastha@gmail.com' where EmployeeID =4  ;  
select * from Employees

SELECT email , count(email)  FROM Employees 
GROUP BY email  
HAVING COUNT(email) > 1 ; 

--Q6

--Retrieve departments having more than 5 employees.
SELECT Department , COUNT(EmployeeID) AS EMPCOUNT
FROM Employees
GROUP BY Department 
HAVING COUNT(EmployeeID) > 3 

--Q7

--Display the second highest salary. 

SELECT DISTINCT(SALARY) AS SECONDHIGHESTSALARY
FROM Employees 
ORDER BY Salary DESC
OFFSET 3 ROWS
FETCH NEXT 1 ROWS ONLY 

--Q8

--Display the nth highest salary. 
SELECT DISTINCT Salary FROM Employees ORDER BY Salary DESC

DECLARE @N INT = 4 ;  
DECLARE @SKIP INT = @N - 1 ; 

SELECT DISTINCT Salary 
FROM Employees 
ORDER BY Salary DESC 
OFFSET @SKIP ROWS 
FETCH NEXT 1 ROWS ONLY 