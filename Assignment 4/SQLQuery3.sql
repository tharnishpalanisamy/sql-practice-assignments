--Create a table with 25 records for various departments using the following details:
--studentid(pk), studentname, department, score

CREATE TABLE department (
studentId int primary key , 
studentName varchar(20) , 
departmentName varchar(30) , 
score int
)

INSERT INTO department (studentId, studentName, departmentName, score)
VALUES
(1, 'Arun', 'CSE', 85),
(2, 'Kavin', 'BCA', 78),
(3, 'Rahul', 'EEE', 91),
(4, 'Vignesh', 'MECH', 67),
(5, 'Sanjay', 'CIVIL', 74),
(6, 'Priya', 'CSE', 88),
(7, 'Divya', 'BCA', 92),
(8, 'Nisha', 'EEE', 81),
(9, 'Hari', 'MECH', 69),
(10, 'Deepak', 'CIVIL', 73),
(11, 'Ajay', 'CSE', 95),
(12, 'Surya', 'BCA', 84),
(13, 'Keerthi', 'EEE', 77),
(14, 'Lavanya', 'MECH', 66),
(15, 'Rohit', 'CIVIL', 79),
(16, 'Madhan', 'CSE', 82),
(17, 'Pooja', 'BCA', 90),
(18, 'Anu', 'EEE', 71),
(19, 'Gokul', 'MECH', 64),
(20, 'Varun', 'CIVIL', 87),
(21, 'Sneha', 'CSE', 93),
(22, 'Harish', 'BCA', 75),
(23, 'Monika', 'EEE', 89),
(24, 'Yogesh', 'MECH', 68),
(25, 'Akash', 'CIVIL', 80);


--1. Create a non-clustered index for department.

CREATE NONCLUSTERED INDEX deptIndex 
on department(departmentName)
sp_helpindex department

--2. Create a filtered index for department='BCA'

CREATE NONCLUSTERED INDEX filteredIndexBca 
on department(departmentName) 
where departmentName = 'BCA'

--3. Create a view for students in BCA department.

CREATE VIEW bcaStudents as (
select * from department where departmentName = 'BCA'
)
select * from bcaStudents

--4. Apply Rank() for all the students based on score.

select studentId , studentName , departmentName ,score,
RANK() OVER(partition by departmentName order by score desc) 
score from department

--5. Apply Dense_Rank() for students in each department based on score.
select studentId , studentName , departmentName , score , 
DENSE_RANK() over(partition by departmentName order by score desc)
from department

--b. Create 2 tables Manager(id(pk), name) and Employee(eid(pk),ename,mid(fk), department).

create table manager(
managerId int primary key , 
name varchar(20)
)

create table employee(
empId int primary key , 
managerId int foreign key references manager(managerId)  , 
department varchar(20)
)

INSERT INTO manager (managerId, name)
VALUES
(1, 'Arun Kumar'),
(2, 'Vignesh'),
(3, 'Suresh'),
(4, 'Karthik'),
(5, 'Dinesh'),
(6, 'Praveen'),
(7, 'Lokesh'),
(8, 'Ramesh'),
(9, 'Madhan'),
(10, 'Harish'),
(11, 'Naveen'),
(12, 'Ajay'),
(13, 'Santhosh'),
(14, 'Deepak'),
(15, 'Rahul');


INSERT INTO employee (empId, managerId, department)
VALUES
(101, 1, 'HR'),
(102, 2, 'Finance'),
(103, 3, 'IT'),
(104, 4, 'Marketing'),
(105, 5, 'Sales'),
(106, 6, 'HR'),
(107, 7, 'Finance'),
(108, 8, 'IT'),
(109, 9, 'Marketing'),
(110, 10, 'Sales'),
(111, 11, 'HR'),
(112, 12, 'Finance'),
(113, 13, 'IT'),
(114, 14, 'Marketing'),
(115, 15, 'Sales');



--1. Create a complex view by retrieving the records from Manager and Employee table.

create View employeeManager as 
select e.empId , e.managerId , m.name , e.department from employee e join manager m on e.managerId = m.managerId

select * from employeeManager

--2. Show the working of  'ON DELETE CASCADE’ , ON UPDATE SET DEFAULT, ON UPDATE SET NULL for the above tables 

create table employeeCascade (

id int primary key , 
name varchar(20) , 
managerId int foreign key references manager(managerId) 

on DELETE CASCADE
)

INSERT INTO employeeCascade (id, name, managerId)
VALUES
(1, 'Arun', 1),
(2, 'Kavin', 2),
(3, 'Rahul', 3),
(4, 'Vignesh', 4),
(5, 'Sanjay', 5),
(6, 'Deepak', 6),
(7, 'Hari', 7),
(8, 'Ajay', 8),
(9, 'Lokesh', 9),
(10, 'Ramesh', 10),
(11, 'Madhan', 11),
(12, 'Praveen', 12),
(13, 'Harish', 13),
(14, 'Naveen', 14),
(15, 'Surya', 15);

delete from manager where managerId = 1 ; 
select * from employeeCascade


--ON UPDATE SET NULL

create table employeeSetNull (
id int primary key , 
name varchar(20) , 
managerId int foreign key references manager(managerId) 

on update set NULL

)

INSERT INTO employeeSetNull (id, name, managerId)
VALUES
(2, 'Kavin', 2),
(3, 'Rahul', 3),
(4, 'Vignesh', 4),
(5, 'Sanjay', 5),
(6, 'Deepak', 6),
(7, 'Hari', 7),
(8, 'Ajay', 8),
(9, 'Lokesh', 9),
(10, 'Ramesh', 10),
(11, 'Madhan', 11),
(12, 'Praveen', 12),
(13, 'Harish', 13),
(14, 'Naveen', 14),
(15, 'Surya', 15);

drop table employeeCascade
update  manager set managerId = 20 where managerId = 2 
select * from employeeSetNull


--ON UPDATE SET DEFAULT

CREATE TABLE employee(
    empId INT PRIMARY KEY,
    managerId INT,
    department VARCHAR(20),

    FOREIGN KEY(managerId)
    REFERENCES manager(managerId)
);

CREATE TABLE employeeSetDefault(
    empId INT PRIMARY KEY,
    managerId INT DEFAULT 20,
    department VARCHAR(20),

    FOREIGN KEY(managerId)
    REFERENCES manager(managerId)
    ON UPDATE SET DEFAULT
);

INSERT INTO employeeSetDefault (empId, managerId, department)
VALUES
(101, 3, 'HR'),
(102, 4, 'Finance'),
(103, 5, 'IT'),
(104, 6, 'Marketing'),
(105, 7, 'Sales');

UPDATE manager
SET managerId = 100
WHERE managerId = 3;

SELECT * FROM employeeSetDefault;
