--joins 

CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50),
    location VARCHAR(50)
);

CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary INT,
    dept_id INT,
    manager_id INT,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);

CREATE TABLE Projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(50),
    emp_id INT,
    budget INT,
    FOREIGN KEY (emp_id) REFERENCES Employees(emp_id)
);

INSERT INTO Departments VALUES
(1, 'HR', 'Chennai'),
(2, 'IT', 'Bangalore'),
(3, 'Finance', 'Mumbai'),
(4, 'Marketing', 'Delhi'),
(5, 'Support', 'Hyderabad');

INSERT INTO Employees VALUES
(101, 'Arun', 50000, 2, NULL),
(102, 'Priya', 45000, 1, 101),
(103, 'Kavin', 60000, 2, 101),
(104, 'Sneha', 55000, 3, 103),
(105, 'Rahul', 40000, 4, 103),
(106, 'Meena', 35000, NULL, 101),
(107, 'Vijay', 70000, 2, NULL),
(108, 'Divya', 48000, 5, 107);


INSERT INTO Projects VALUES
(201, 'Website', 101, 100000),
(202, 'Payroll', 102, 50000),
(203, 'AI Chatbot', 103, 200000),
(204, 'Marketing Campaign', 105, 75000),
(205, 'Customer Support System', 108, 90000),
(206, 'Bank Audit', 104, 120000);


select * from Projects

--inner join 
--Show employee names with their department names.
select e.emp_name , d.dept_name from Employees e inner join Departments d on e.dept_id = d.dept_id ; 

--Show employee name and department location. 
select e.emp_name , d.location from Employees e inner join Departments d on e.dept_id = d.dept_id

--Show all projects with employee names. 
select p.project_name , e.emp_name from Projects p join Employees e on p.emp_id = e.emp_id ;

--LEFT JOIN
--Show all employees even if they don't belong to a department.
select * from Employees left join Departments on Employees.dept_id = Departments.dept_id ; 

--Show all departments even if no employee works there.
select * from Departments d left join Employees e on d.dept_id = e.dept_id ; 

--Multiple JOINs
--Show: employee name department name project name 
select e.emp_name , d.dept_name , p.project_name from Employees e join Departments d on e.dept_id = d.dept_id join Projects p on e.emp_id = p.emp_id 

--Find employees working in Bangalore. 
select * from Employees e join Departments d on e.dept_id = d.dept_id where d.location = 'Bangalore';

--Show projects handled by IT department employees. 

select * from Projects p inner join Employees e on p.emp_id = e.emp_id join Departments d on e.dept_id = d.dept_id where d.dept_name = 'IT'

--Aggregate + JOIN
--Find average salary department-wise. 
select d.dept_name, avg(e.salary) from Employees e join Departments d on e.dept_id = d.dept_id  group by d.dept_name ; 

--Find highest salary in each department.
select d.dept_name , Max(e.salary) from Employees e inner join Departments d on e.dept_id = d.dept_id group by d.dept_name ; 

--Count employees in every department. 
select d.dept_name , count(e.emp_name) as emp_count from Employees e join Departments d on e.dept_id = d.dept_id group by d.dept_name ;

--SELF JOIN 
--Show employee name with their manager name. 
select e1.emp_name , e2.emp_name from Employees e1 join Employees e2 on e1.manager_id = e2.emp_id ;  -- manager name is not available 

--Advanced 
--Find employees earning more than average salary of their department. 
select e.emp_name , d.dept_name , e.salary from Employees e join Departments d on e.dept_id = d.dept_id where e.salary > 
(select avg(e2.salary) from Employees e2 where e.dept_id = e2.dept_id )

--Find department with highest total salary. 
select d.dept_name , sum(e.salary) as total_salary from Employees e join Departments d on e.dept_id = d.dept_id group by d.dept_name  
order by total_salary desc offset 0 rows fetch next 1 rows only

--Show employees who are not assigned any project.

select e.* from Employees e left join Projects p on e.emp_id = p.emp_id where p.emp_id is NULL

--Show departments where average salary > 50000.
select d.dept_name , avg(e.salary) as total from Departments d join Employees e on d.dept_id = e.dept_id group by d.dept_name 
having avg(e.salary) > 50000

--Find managers who manage more than 2 employees.
select manager_id , count(manager_id) from Employees group by manager_id having count(manager_id) >2

--Bonus Challenge
-- Show: employee name manager name department project budget

select e.emp_name , e2.emp_name , d.dept_name , p.project_name , p.budget from Employees e join Employees e2 on e.manager_id = e2.emp_id 
join Departments d on e.dept_id = d.dept_id 
join Projects p on e.emp_id = p.emp_id 

select e2.emp_name as manager,
count(*) as employees_managed
from Employees e1
join Employees e2
on e1.manager_id = e2.emp_id
group by e2.emp_name
having count(*) > 2;

select *,sum(salary) from Employees