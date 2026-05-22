CREATE TABLE Trainees (
TRAINEE_ID INT NOT NULL PRIMARY KEY,
FIRST_NAME CHAR(25),
LAST_NAME CHAR(25),
SALARY INT,
JOINING_DATE DATETIME,
DEPARTMENT CHAR(25)
);


INSERT INTO Trainees
(TRAINEE_ID, FIRST_NAME, LAST_NAME, SALARY,
JOINING_DATE, DEPARTMENT) VALUES
(002, 'Niharika', 'Verma', 80000, '2023-03-20', 'Admin'),
(003, 'Vishal', 'Singhal', 300000, '2023-03-20', 'HR'),
(004, 'Amitabh', 'Singh', 500000, '2023-03-20', 'Admin'),
(005, 'Vivek', 'Bhati', 500000, '2023-03-20', 'Admin'),
(006, 'Vipul', 'Diwan', 200000, '2023-03-20', 'Account'),
(007, 'Satish', 'Kumar', 75000, '2023-03-20', 'Account'),
(008, 'Geetika', 'Chauhan', 90000, '2023-03-20', 'Admin');

select * from Trainees

--1.	Write an SQL query to get the count of employees in each department.
select DEPARTMENT , count(TRAINEE_ID) as Employees from Trainees group by DEPARTMENT

--2.	Write an SQL query to calculate the estimated induction program day for the trainees from 5 days from JOINING_DATE.
select TRAINEE_ID,First_name  as Name , JOINING_DATE , DATEADD(DAY,5,JOINING_DATE) as induction  from Trainees

--3.	Write an SQL query to retrieve the month in words from the Trainees table - JOINING_DATE Column.
select format(JOINING_DATE,'MMMM') as Month from Trainees

--4.	Write an SQL query to perform the total and subtotal of salary in each department.
select ISNULL(DEPARTMENT,'Grand Total') as Department , sum(salary) as Subtotal   from Trainees group by rollup(DEPARTMENT)


--5.	Write an SQL query to retrieve first 3 records randomly.
select top 3 * from Trainees order by NEWID()

--6.	Show the working of composite key with any example.

CREATE TABLE ACCOUNT (
accNo int , 
balance decimal(10,2) , 
pin int , 
accHolder varchar(30) , 
PRIMARY KEY(accNo,pin) )

INSERT INTO ACCOUNT VALUES
(1001, 25000.50, 1234, 'Arun Kumar'),
(1002, 18000.00, 2345, 'Kavin'),
(1003, 32000.75, 1234, 'Praveen'),
(1004, 15000.25, 4567, 'Surya'),
(1005, 50000.00, 5678, 'Vignesh'),
(1005, 15000.25, 4567, 'Kathik')
;
-- any one column can be duplicated as a pair they shiuld be unique

--7.	Show the working of IIF and CASE for the above table.
--IIF is like if else statement iif(condition , true values , false value) 
select accHolder , balance , IIF(balance >= 30000 , 'current account' , 'savinf account '  ) as status from ACCOUNT

--case is more powerful version its like switch case in programming 

select accHolder , balance , 
CASE
WHEN balance >= 40000 THEN 'premium' 
WHEN balance >= 30000 THEN 'standard' 
ELSE 'basic' 
END as Account_type
from ACCOUNT 

--8.	Show the working of Sequence.
CREATE SEQUENCE rollNo 
start with 1 
increment by 1 

create table student (
id int , 
name varchar(30) 
)
insert into student values 
(NEXT VALUE FOR rollNo , 'tharnish') , 
(NEXT VALUE FOR rollNo , 'Prajin'),
(NEXT VALUE FOR rollNo , 'Ram'),
(NEXT VALUE FOR rollNo , 'Naveen')

select * from student

--9.	Show the working of creation of Synonym for a table in DB1 from DB2.
CREATE SYNONYM person for AdventureWorks2022.Person.Person

select * from person
SELECT * FROM sys.synonyms;

--10.	Show the working of IDENTITY_INSERT.

create table student (
rollNo int identity(1,1) , 
name varchar(20) 
)

--normal insert 
insert into student values 
('tharnish') , 
('Naveen')

set IDENTITY_INSERT student on ; 

insert into student (rollNo,name)
values 
(100,'ram') , 
(150,'joseph')

select * from student 
SET IDENTITY_INSERT student OFF;