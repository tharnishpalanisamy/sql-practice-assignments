CREATE TABLE Department
(
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50),
    Location VARCHAR(50)
);

CREATE TABLE Employee
(
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    DepartmentID INT,
    ManagerID INT,
    Salary DECIMAL(10,2),
    JoiningDate DATE,
    ExperienceYears INT,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

CREATE TABLE Project
(
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(50),
    Budget DECIMAL(12,2),
    DepartmentID INT
);

CREATE TABLE EmployeeProject
(
    EmpID INT,
    ProjectID INT,
    HoursWorked INT,
    PRIMARY KEY(EmpID, ProjectID)
);

CREATE TABLE Sales
(
    SaleID INT PRIMARY KEY,
    EmpID INT,
    SaleAmount DECIMAL(10,2),
    SaleDate DATE
);





INSERT INTO Department VALUES
(101,'HR','Chennai'),
(102,'IT','Bangalore'),
(103,'Finance','Mumbai'),
(104,'Admin','Hyderabad');


INSERT INTO Employee VALUES
(10,'Sara',104,NULL,90000,'2023-06-01',2),
(9,'Sara',104,NULL,40000,'2023-06-01',2),
(1,'Arjun',101,NULL,90000,'2020-01-10',8),
(2,'Ajomina',101,1,70000,'2021-02-15',5),
(3,'Kavin',102,1,85000,'2019-03-12',7),
(4,'Meena',102,3,65000,'2022-04-01',3),
(5,'Ravi',103,1,50000,'2023-01-11',2),
(6,'John',101,1,95000,'2018-07-18',10),
(7,'David',103,5,45000,'2024-01-01',1),
(8,'Sara',104,NULL,40000,'2023-06-01',2);


INSERT INTO Project VALUES
(1001,'Payroll System',500000,101),
(1002,'AI Platform',900000,102),
(1003,'Tax Automation',300000,103),
(1004,'HR Portal',250000,101);

INSERT INTO EmployeeProject VALUES
(1,1001,120),
(2,1001,90),
(3,1002,150),
(4,1002,110),
(5,1003,60),
(6,1004,140);

INSERT INTO Sales VALUES
(1,1,50000,'2025-01-01'),
(2,2,20000,'2025-01-03'),
(3,3,70000,'2025-01-10'),
(4,1,40000,'2025-02-01'),
(5,5,15000,'2025-02-10'),
(6,3,50000,'2025-02-15');




--Qn 1
--Find employees earning more than average salary.
--Concepts
--•	Scalar subquery 
--•	Aggregate function 

select * from Employee where Salary > (select AVG(salary) from Employee ) 

--Qn 2
--Find employees working in departments located in Chennai.
--Concepts
--•	IN subquery 
select * from Employee where DepartmentID in (select DepartmentID from Department where Location = 'chennai')

--Qn 3
--Find employees who are assigned to at least one project.
--Concepts
--•	EXISTS 

select * from Employee where  exists  (select 1 from Project where Project.DepartmentID = Employee.DepartmentID)

--Qn 4
--Find departments that do not have employees.
--Concepts -- NOT EXISTS 
select * from Department d where not exists (select 1 from Employee e where d.DepartmentID = e.DepartmentID)
--Qn 5
--Find employees earning highest salary.

select * from Employee where Salary = (select max(salary) from Employee)

--Qn 6
--Find employees whose salary is greater than their manager salary.
--Concepts
--•	Correlated subquery 

select * from Employee e where e.Salary > (select Salary from Employee e2 where e.ManagerID = e2.EmpID) 


--Qn 7
--Find projects having budget greater than average project budget.

select * from Project where Budget > (select avg(budget) from Project)


--Qn 8
--Find employees who joined before the latest joining date in their department.
--Concepts
--•	Correlated subquery 

select * from Employee e where e.JoiningDate < 
(select max(e2.joiningDate) from Employee e2 where e.DepartmentID = e2.DepartmentID group by DepartmentID )


--Qn 9
--Find second highest salary employee in each department.
--Concepts
--•	Correlated subquery 
--•	COUNT 
--•	DISTINCT 


select e1.EmpID , e1.EmpID , e1.Salary as secondHighest from Employee e1 where 1 = (select count(distinct(e2.salary)) from Employee e2 
where e1.DepartmentID = e2.DepartmentID  AND e1.Salary < e2.Salary)


select distinct(salary) from Employee order by Salary desc offset 1 rows fetch next 1 rows only 

--Qn 10
--Find employees earning more than department average and having experience greater than department average experience.
--Concepts
--•	Multiple correlated subqueries 

select * from Employee e1 where Salary > (select avg(salary) from Employee e2 where e1.DepartmentID = e2.DepartmentID) 
and ExperienceYears > (select avg(ExperienceYears ) from Employee e3 where e1.DepartmentID = e3.DepartmentID ) 

--Qn 11
--Find departments where total employee salary exceeds average departmental salary total.
--Concepts
--•	Derived table 
--•	Nested aggregate 

select DepartmentID , sum(salary) from Employee group by DepartmentID having sum(salary) > 
(select avg(totalSalary) from (select DepartmentID , sum(salary) as totalSalary  from Employee group by DepartmentID ) as deptTotal)



--Qn 12
--Find employees who worked on projects with maximum budget in their department.
--Concepts
--•	Correlated subquery 
--•	Nested subquery 

select * from Employee
select * from Project
select * from EmployeeProject

select * from Employee e join EmployeeProject ep on ep.EmpID = e.EmpID join Project p on p.ProjectID = ep.ProjectID 
where p.Budget = (select max(budget) from Project) 

select * from Employee e where e.EmpID in (select ep.EmpID from EmployeeProject ep where ep.ProjectID in 
(select p.projectId from Project p where p.Budget = (select max(budget) from Project p2 where p.DepartmentID = p2.departmentId)) )

--Qn 13
--Find employees whose sales are greater than average sales of all employees.
--Concepts
--•	Correlated aggregate 
select * from Sales
--select * from Employee 

select e.EmpID , e.EmpName , sum(s.saleAmount)  from Employee e 
join sales s on e.EmpID = s.EmpID group by e.EmpID , e.EmpName 
having sum(s.saleAmount) > (select avg(saleAmount) from 
(select sum(saleAmount ) as saleAmount from sales group by SaleAmount) as saleTotal )

--Qn 14
--Find employees who are not assigned to any project. 

select * from Employee e where not exists (select 1 from EmployeeProject ep where e.EmpID = ep.EmpID )
select * from EmployeeProject
--Qn 15
--Find employees having maximum sales in each month.
--Concepts
--•	Correlated subquery 
--•	GROUP BY 

SELECT e.EmpID,
       e.EmpName,
       MONTH(s.SaleDate) AS SaleMonth,
       SUM(s.SaleAmount) AS TotalSales
FROM Employee e
JOIN Sales s
    ON e.EmpID = s.EmpID
GROUP BY e.EmpID,
         e.EmpName,
         MONTH(s.SaleDate)
HAVING SUM(s.SaleAmount) = (
    SELECT MAX(MonthlySales)
    FROM (
        SELECT SUM(s2.SaleAmount) AS MonthlySales
        FROM Sales s2
        WHERE MONTH(s2.SaleDate) = MONTH(s.SaleDate)
        GROUP BY s2.EmpID
    ) AS MonthTotals
);

select e.EmpID , e.EmpName , month(s.SaleDate) , sum(s.SaleAmount) 
from Employee e join Sales s on e.EmpID = s.EmpID
group by e.EmpID , e.EmpName , month(s.SaleDate) 
having sum(s.SaleAmount) = (select max(monthSale) from(
select sum(s2.SaleAmount) as monthSale from Sales s2 where MONTH(s.SaleDate) = MONTH(s2.SaleDate) 
group by s2.EmpID
)  as monthWiseTotal 

)


select * from Department
select * from Employee
select * from Project
select * from EmployeeProject
select * from Sales


--Qn 16
--Find duplicate salaries within same department.
select DepartmentID , salary from Employee group by DepartmentID , Salary having count(Salary) > 1

--Qn 17
--Find employees earning top 3 salaries in each department.
--Concepts
--•	Correlated subquery 
--•	Ranking logic 


select * from Employee e where 3 > (select count(distinct e2.salary) from Employee e2 
where e.DepartmentID = e2.DepartmentID AND
e.salary < e2.Salary )

--Qn 18
--Find employees whose project hours exceed average project hours.

select * from EmployeeProject where HoursWorked > (select avg(HoursWorked) from EmployeeProject )

--Qn 19
--Find managers having more than 2 subordinates.

select e2.EmpName,e2.empId from Employee e1 join Employee e2 on e1.ManagerID = e2.EmpID 
group by e2.EmpID , e2.EmpName having count(e1.empId) > 2 ;

--Qn 20
--Find employees who belong to departments with highest total salary expense.
--Concepts
--•	Nested subqueries 
--•	Derived tables 

select DepartmentID , sum(salary) from Employee  group by DepartmentID 

select * from Employee e where DepartmentID in (
select DepartmentID from (
select DepartmentID , sum(salary) as totalSalary from Employee group by DepartmentID) as deptTotal where 
totalSalary = (select max(totalSalary) from (select DepartmentID , sum(salary) as totalSalary
from Employee group by DepartmentID) as DeptMax
))

select * from Department

--ADVANCED INTERVIEW-LEVEL TASKS
--Qn 21
--Find employees whose salary is greater than ALL employees in Finance department.
select * from Employee where salary > (select max(e.salary) from Employee e	 
join Department d on e.DepartmentID = d.DepartmentID where d.DepartmentName ='Finance')

select * from Employee
--Qn 22
--Find employees whose salary matches any employee in HR department.
select * from Employee e 
where DepartmentID <>'101' and
salary in (select salary from Employee where DepartmentID = '101')

--Qn 23
--Find latest joined employee in each department.
select e1.EmpName , e1.DepartmentID from Employee e1  where JoiningDate = 
(select max(joiningDate) from Employee e2 where e1.DepartmentID = e2.DepartmentID )

--Qn 24
--Delete duplicate employee records based on salary and department.

delete from Employee where Exists (
select 1 from Employee e1 where Employee.EmpID > e1.EmpID  
AND Employee.DepartmentID = e1.DepartmentID 
AND Employee.Salary = e1.Salary)

select * from Employee

--Qn 25
--Update employees salary by 5% if salary is below department average. 
with avg_salary as (
select avg(salary) as avgSalary from Employee ) 
update Employee set Salary = Salary * 0.05 from Employee , avg_salary 
where Salary > avg_salary.avgSalary 



