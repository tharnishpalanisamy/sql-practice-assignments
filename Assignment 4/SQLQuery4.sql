--Task – 4
--following table.
--Create User-define Scalar function to calculate percentage of all students after creating the
--(Create a table with studentid, studentname, semester, securedmarks, totalmarks)
--Sample: 1,'John','Sem 1',450,500

create table student (
studentId int primary key , 
studentName varchar(20) ,
semester int , 
securedMarks decimal(10,2) , 
total decimal(10,2) 

) 
INSERT INTO student (studentId, studentName, semester, securedMarks, total)
VALUES
(1, 'Arun', 1, 450, 500),
(2, 'Kavin', 1, 420, 500),
(3, 'Rahul', 2, 390, 500),
(4, 'Vignesh', 2, 470, 500),
(5, 'Sanjay', 3, 410, 500),
(6, 'Deepak', 3, 380, 500),
(7, 'Hari', 4, 495, 500),
(8, 'Ajay', 4, 430, 500),
(9, 'Lokesh', 5, 405, 500),
(10, 'Ramesh', 5, 460, 500),
(11, 'Madhan', 6, 440, 500),
(12, 'Praveen', 6, 370, 500),
(13, 'Harish', 7, 480, 500),
(14, 'Naveen', 7, 415, 500),
(15, 'Surya', 8, 455, 500);

CREATE FUNCTION calculatePercentage(
@securedMarks decimal(10,2) , 
@total decimal(10,2)
)
returns decimal(10,2)
as
begin 
declare @result decimal(10,2) 

set @result = (@securedMarks / @total) * 100 

return @result 
end


--2. Create user-defined function to generate a table that contains result of Sem 3 students.

create function displayResult(
@semester int)
returns table 
as 
return  (
select * , dbo.calculatePercentage(securedMarks , total) as reult from student where semester = @semester )

select * from dbo.displayResult(3)

--3. Write SQL stored procedure to retrieve all students details. (No parameters)

CREATE PROCEDURE retireveStudents
as
begin 
select * from student
end 

exec retireveStudents

--4. Write SQL store procedure to display Sem 1 students details. (One parameter)

CREATE PROCEDURE retrieveStudentsBySemester 
@semester int 
as
begin 
select * from student where semester = @semester ; 
end 

exec retrieveStudentsBySemester 5

--5. Write SQL Stored Procedure to retrieve total number of students details. (OUTPUT Parameter)

CREATE PROCEDURE retreiveTotalNumberOfStudents
@count int output
as 
begin 
select @count = count(*) from student 
end

declare @result int 

exec retreiveTotalNumberOfStudents @result OUTPUT ; 
SELECT @result AS totalStudents;

--6. Show the working of Merge Statement by creating a backup for the students details of only students in Sem 1.
--Note: Update few values in students details so that you can see the working of UPDATE.

select * into studentBackup from student where semester = 1

select * from studentBackup 

update student set securedMarks = 480 where studentId =1 

MERGE studentBackup as target 
using (
select * from student where semester = 1 
) as source  
on target.studentId = source.studentId
When matched then 
update set 
target.securedMarks = source.securedMarks  , 
target.total = source.total , 
target.studentName  = source.studentName ;

select * from studentBackup 
