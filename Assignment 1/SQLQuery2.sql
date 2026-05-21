

--1. Create a table with primary key, unique key, check and default constraints.
CREATE TABLE training (
empId int primary key , 
name varchar(30) , 
phone varchar(10) unique  , 
check (len(phone) = 10 ) , 
country varchar(20) default 'india'
)

truncate table training
insert into training(empId,name,phone) values 
(1,'tharnish','9798112253'),
(2,'Sanjay','9798412253'),
(3,'Sastha','9798112553'),
(4,'Shawn','9798112259'),
(5,'Vishal','9788112253')

--2. Rename a table, database & schema.	
exec sp_rename	'training' , 'employee';

-- Alter database tharnish modify name = testDb ;  cannot use it when you use the same db 

drop table training  
drop table employee
--3. Create a table with the following fields:
 -- a. id as identity column, name, salary, increment, computed column as Revised salary(salary + increment)

create table employee(
empId int primary key , 
name varchar(30) , 
pay decimal(10,2) , 
bonus decimal(10,2) ,
salary as pay+bonus)  

INSERT INTO employee(empId, name, pay, bonus) VALUES
(1, 'Tharnish', 45000, 5000),
(2, 'Sanjay', 38000, 4000),
(3, 'Vishal', 52000, 7000),
(4, 'Midhun', 29000, 3000),
(5, 'Shawn', 61000, 8000),
(6, 'Devasree', 68000, 2000),
(7, 'Danu Shree', 25000, 5000),
(8, 'Monisha', 17700, 2000),
(9, 'Sastha', 15000, 8000),
(10, 'Sindhuja', 12000, 10000);


--  b. Retrieve all the records whose salary is >20000 and move them into a new table using (SELECT INTO)

select * from employee where salary > 20000;