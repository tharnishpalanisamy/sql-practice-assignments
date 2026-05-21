-- table structure

CREATE TABLE trainees(
empId INT PRIMARY KEY , 
firstName VARCHAR(30) , 
lastName VARCHAR(30) , 
salary INT , 
joiningDate DATETIME , 
company CHAR(3) ); 

--20 records 
INSERT INTO trainees VALUES 
(1,'Devasree', NULL , 75000 , '2026-03-16 09:00:00','G2'),
(2,'Danu', 'Shree' , 70000 , '2026-03-18 10:15:00','G2'),
(3,'Monisha', NULL , 65000 , '2026-03-16 08:45:00','CG'),
(4,'Sastha', NULL , 85000 , '2026-03-16 11:00:00','CG'),
(5,'Shawn', 'Mathew' , 90000 , '2026-03-16 09:30:00','CG'),
(6,'Sanjay', 'Sam Mathew' , 90000 , '2026-03-16 10:00:00','G2'),
(7,'Mithun', NULL , 100000 , '2026-03-17 08:20:00','CG'),
(8,'Sindhuja', NULL , 80000 , '2026-03-20 12:10:00','G2'),
(9,'Tharnish', NULL , 25000 , '2026-03-16 09:45:00','G2'),
(10,'Vishal', NULL , 100000 , '2026-03-17 11:30:00','CG'),
(11, 'Arun', 'Kumar', 25000, '2024-01-15 09:30:00', 'TCS'),
(12, 'priya', 'Sharma', 32000, '2023-11-20 10:15:00', 'CTS'),
(13, 'Rahul', 'Verma', 28000, '2024-03-05 08:45:00', 'TCS'),
(14, 'sneha', 'Reddy', 35000, '2022-12-10 11:00:00', 'CTS'),
(15, 'Vikram', 'Singh', 40000, '2021-07-18 09:00:00', 'TCS'),
(16, 'Anjali', 'Patel', 27000, '2024-05-01 10:30:00', 'CTS'),
(17, 'karthik', 'Raj', 30000, '2023-08-22 12:00:00', 'TCS'),
(18, 'meenas', 'Iyer', 33000, '2022-09-14 09:20:00', 'CTS'),
(19, 'rohits', 'Sharma', 29000, '2024-02-11 08:10:00', 'TCS'),
(20, 'Divyas', 'Nair', 36000, '2023-06-30 11:45:00', 'CTS');

--truncate table trainees
--Retrieve all FIRST_NAME STARTING WITH J-T and should differentiate between Uppercase and lowercase.

--Uppercase
select * from trainees where firstName collate Latin1_General_Bin like '[J-T]%'

--LowerCase
select * from trainees where firstName collate Latin1_General_Bin like '[j-t]%'

--2. Retrieve all SALARY BETWEEN 20000 TO 50000
select empId,firstName,salary from trainees where salary between 20000 and 50000

--3. Retrieve all FIRST_NAME ending with i 
select firstName from trainees where firstName like '%s' ; 

--4. Retrieve all salary without duplications '
select  distinct salary from trainees ; 

--5. Retrieve all records whose department is Developer and Designer 
select * from trainees where company in ('G2','CG')

--6. Retrieve all Trainee_ID less than 5
select * from trainees where empId < 5 ; 

--7. Limit the records by retrieving the 6 to 15 records
select * from trainees order by empId offset 5 rows fetch next 10 rows only

--8. Retrieve the top 5 records with Ties
select top 3 with ties salary from trainees order by salary desc; 

--9. Retrieve the records in descending order based on department column.
select * from trainees order by company ;

--10. Retrieve all  last_name with 3rd character as 'a.' 
select lastName from trainees where lastName like '__a%'