CREATE TABLE Departments
(
    DeptId INT PRIMARY KEY,
    DeptName VARCHAR(50)
);

CREATE TABLE Employees
(
    EmpId INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Salary DECIMAL(10,2),
    DeptId INT,
    ManagerId INT NULL
);

CREATE TABLE Projects
(
    ProjectId INT PRIMARY KEY,
    ProjectName VARCHAR(100)
);


CREATE TABLE EmployeeProjects
(
    EmpId INT,
    ProjectId INT
);

CREATE TABLE Customers
(
    CustomerId INT PRIMARY KEY,
    CustomerName VARCHAR(50)
);

CREATE TABLE Orders
(
    OrderId INT PRIMARY KEY,
    CustomerId INT,
    OrderAmount DECIMAL(10,2)
);

CREATE TABLE Courses
(
    CourseId INT PRIMARY KEY,
    CourseName VARCHAR(50)
);

CREATE TABLE Students
(
    StudentId INT PRIMARY KEY,
    StudentName VARCHAR(50),
    CourseId INT NULL
);

INSERT INTO Departments VALUES
(1,'HR'),
(2,'Admin'),
(3,'Development'),
(4,'Testing');


INSERT INTO Employees VALUES
(101,'Arun',50000,1,NULL),
(102,'Bala',60000,2,101),
(103,'Charan',70000,3,101),
(104,'David',45000,NULL,102),
(105,'Ezhil',55000,3,103);


INSERT INTO Projects VALUES
(1,'Banking App'),
(2,'E-Commerce'),
(3,'AI Chatbot');

INSERT INTO EmployeeProjects VALUES
(101,1),
(102,1),
(103,2),
(105,3);

INSERT INTO Customers VALUES
(1,'Ravi'),
(2,'Kumar'),
(3,'Ajay');

INSERT INTO Orders VALUES
(1001,1,5000),
(1002,1,2500),
(1003,2,4000);



INSERT INTO Courses VALUES
(1,'SQL'),
(2,'Python'),
(3,'AI');


INSERT INTO Students VALUES
(1,'John',1),
(2,'Mary',2),
(3,'Steve',NULL);


--Qn 1 — INNER JOIN
--Display employee name and department name.

select e.EmpName , d.DeptName from  Employees e join Departments d on e.DeptId	 = d.DeptId


--Qn 2 — LEFT JOIN
--Display all employees including employees without department.

select * from Employees e left join Departments d on e.DeptId = d.DeptId ; 

--Qn 3 — RIGHT JOIN
--Display all departments including departments without employees.

select * from Employees e right join Departments d on e.DeptId = d.DeptId ; 

--Qn 4 — FULL JOIN
--Display all employees and all departments.
select * from Employees e full join Departments d on e.DeptId = d.DeptId 

--Qn 5 — SELF JOIN
--Display employee name and manager name.

select e1.EmpName , e2.EmpName as manager from Employees e1 join Employees e2 on e1.ManagerId = e2.EmpId ; 

--Qn 6 — CROSS JOIN
--Generate all employee-project combinations.

select * from Employees e cross join Projects p 


--Qn 7 — Multiple INNER JOINs
--Display employee name with department and assigned project.
select e.EmpName , d.DeptName , p.ProjectName from Employees e join Departments d on e.DeptId = d.DeptId 
join EmployeeProjects ep on e.EmpId = ep.EmpId 
join Projects p on ep.ProjectId = p.ProjectId

--Qn 8 — Employees Without Projects
--Find employees not assigned to any project.

select * from Employees where EmpId not in (select EmpId from EmployeeProjects ) 

--Qn 9 — Departments Without Employees
select * from Departments where DeptId not in (select DeptId from Employees where DeptId is not null )

--Qn 10 — Customers Without Orders
select * from Customers c where c.CustomerId not in (select CustomerId from Orders ) 

--Qn 11 — Total Order Amount Per Customer
select c.CustomerName , sum(o.orderAmount) as Total_purchase  from Customers c join Orders o on c.CustomerId = o.CustomerId group by c.CustomerName


--Qn 12 — Employee Count Per Department
select d.DeptName , count(*) as Employee_count from Employees e join Departments d on e.DeptId = d.DeptId group by d.DeptName 

--Qn 13 — Highest Salary Employee Per Department
select d.DeptId , d.DeptName , e.EmpName , e.Salary from Departments d join Employees e on d.DeptId = e.DeptId 
where e.Salary = (select max(salary) from Employees where Employees.DeptId =  e.DeptId)

--Qn 14 — Employees and Their Projects
select * from Employees e  join EmployeeProjects ep on e.EmpId = ep.EmpId ; 

--Qn 15 — Students Without Courses
select * from Students where CourseId is null  -- simple 
select * from Students where not exists (select 1 from Courses c where Students.CourseId = c.CourseId )


--Qn 16 — Find Managers with Their Team Members
select e.EmpName , m.EmpName as managerName from Employees e join Employees m on e.ManagerId = m.EmpId ; 

--Qn 17 — Find Employees Working in Same Department
select * from Employees e where DeptId in (select DeptId from Employees group by DeptId having count(*) > 1 ); 

--Qn 18 — Employees with Multiple Projects
select e.EmpId , e.EmpName , count(ep.ProjectId) from Employees e join EmployeeProjects ep on e.EmpId = ep.EmpId  
group by e.EmpId , e.EmpName having count(ep.projectId) > 1 ;  --- because no is having multiple projects  

select ep.ProjectId ,COUNT(e.EmpId) AS TotalEmployees   
from  Employees e join EmployeeProjects ep on e.EmpId = ep.EmpId 
group by ep.ProjectId
having count(e.EmpId) > 1

--Qn 19 — Department Wise Total Salary
select d.DeptName , sum(e.salary)  from Employees e join Departments d on e.DeptId = d.DeptId group by d.DeptName


--Qn 20 — Find Employees Reporting to Arun 

select * from Employees e where e.ManagerId = (select EmpId from Employees where EmpName = 'arun')


