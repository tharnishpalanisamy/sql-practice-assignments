CREATE TABLE Trainees (
Trainee_ID INT PRIMARY KEY,
FIRST_NAME CHAR(25),
LAST_NAME CHAR(25),
SALARY INT,
JOINING_DATE DATETIME,
DEPARTMENT CHAR(25)
);

INSERT INTO Trainees (Trainee_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT) VALUES
(1, 'John', 'Doe', 45000, '2025-01-15 09:00:00', 'HR'),
(2, 'Jane', 'Smith', 52000, '2025-01-18 09:30:00', 'IT'),
(3, 'Michael', 'Brown', 60000, '2025-02-01 10:00:00', 'Finance'),
(4, 'Emily', 'Davis', 48000, '2025-02-10 09:15:00', 'Marketing'),
(5, 'David', 'Wilson', 55000, '2025-03-01 11:00:00', 'IT'),
(6, 'Sarah', 'Martinez', 62000, '2025-03-15 09:00:00', 'Finance'),
(7, 'James', 'Anderson', 43000, '2025-04-02 10:30:00', 'HR'),
(8, 'Amanda', 'Taylor', 51000, '2025-04-12 09:00:00', 'Marketing'),
(9, 'Robert', 'Thomas', 58000, '2025-05-01 11:15:00', 'IT'),
(10, 'Lisa', 'Jackson', 65000, '2025-05-18 09:00:00', 'Finance'),
(11, 'William', 'White', 46000, '2025-06-01 09:45:00', 'HR'),
(12, 'Megan', 'Harris', 53000, '2025-06-10 10:00:00', 'Marketing'),
(13, 'Brian', 'Martin', 57000, '2025-07-01 09:00:00', 'IT'),
(14, 'Rachel', 'Clark', 61000, '2025-07-15 11:30:00', 'Finance'),
(15, 'Kevin', 'Lewis', 44000, '2025-08-01 09:15:00', 'HR'),
(16, 'Alicia', 'Walker', 50000, '2025-08-12 10:00:00', 'Marketing'),
(17, 'Jason', 'Young', 56000, '2025-09-01 09:00:00', 'IT'),
(18, 'Tiffany', 'Allen', 63000, '2025-09-15 13:00:00', 'Finance'),
(19, 'Charles', 'King', 47000, '2025-10-01 09:30:00', 'HR'),
(20, 'Kimberly', 'Wright', 54000, '2025-10-10 10:15:00', 'Marketing');


select FIRST_NAME from Trainees where FIRST_NAME like '[J-T]%' COLLATE SQL_Latin1_General_CP1_CS_AS ; 

select * from Trainees where SALARY between 20000 and 50000 

select * from Trainees where FIRST_NAME like '%s' 

select distinct(salary) from Trainees

select * from Trainees where DEPARTMENT in ('IT' , 'Marketing')

select * from Trainees order by Trainee_ID offset 5 rows fetch next 10 rows only 

select top(5) with ties * from Trainees where DEPARTMENT = 'Marketing'  order by DEPARTMENT desc 

select * from Trainees order by DEPARTMENT desc

select * from Trainees where LAST_NAME like '__e%'


create table sample(
id int primary key identity(1,1) , 
rollno int unique  , 
salary money check (salary > 30000) , 
country varchar(30) default 'india'
)


insert into sample1 (rollno , salary , increment) values (3 , 100000 , 2000)

select * from sample1

exec sp_rename 'sample' , 'sample1' ; 


alter table sample1 add increment money 


alter table sample1 add totalSalary as salary + increment ; 


select * into highPaid from  (select * from Trainees where SALARY > 60000 ) as salary

select * from highPaid

select UPPER(FIRST_NAME) from Trainees ; 

select distinct(DEPARTMENT) from Trainees

select SUBSTRING(FIRST_NAME , 1 , 3 ) from Trainees

select * from Trainees where FIRST_NAME like '%a%'























