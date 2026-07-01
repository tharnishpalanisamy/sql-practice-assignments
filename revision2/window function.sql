
--Phase 6 – Window Functions

--Most important office topic.

--Q40

--Department average salary using OVER() 
select distinct DeptID , avg(salary) over(partition by deptId) as averageSalary
from Employees

--Q41

--Running total of sales.
select * , sum(SalesAmount) over(order by empId) as runningTotal from Employees

--Q42

--Department maximum salary without GROUP BY.

select distinct  DeptID , max(salary) over(partition by deptId) as maxSalary
from Employees

--Q43

--Salary difference from department maximum.

select * , max(salary) over(partition by deptId) - salary as differenceS
from 
Employees

--Q44

--Department-wise cumulative salary.

select * , sum(salary) over(partition by deptId order by Salary) as cumulative
from Employees
--Q45

--Percentage contribution within department. 
select * , salary * 100 / sum(salary) over(partition by deptId)  as contribution
from Employees