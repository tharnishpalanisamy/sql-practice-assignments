--Phase 7 – Ranking Functions
--Q46

--Apply ROW_NUMBER()

select * , ROW_NUMBER() over(order by empId) as rn
from Employees

--Q47

--Apply RANK()

select *  , RANK() over(order by salary desc) as rank
from Employees

--Q48

--Apply DENSE_RANK()

select *  , DENSE_RANK() over(order by salary desc)
from Employees

--Q49

--Find top 2 salaries in each department.
with topSalaries as (
select *  , DENSE_RANK() over(partition by deptId order by salary desc) as salaryRank
from Employees
) 
select * from topSalaries where salaryRank <= 2 


--Q50

--Find bottom 3 salaries in each department.

with lowSalaries as (
select * , DENSE_RANK() over(partition by deptId order by salary) as salaryRank
from Employees 
) 
select * from lowSalaries where salaryRank <= 3