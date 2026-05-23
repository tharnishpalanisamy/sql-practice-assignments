--1. Write a Stored Procedure in SQL using conditional statements to search for a record from the students table 
--(created in SQL Task 4) based on studentname column.

CREATE PROCEDURE searchStudent 
@studentName varchar(20) 

as 
begin 
IF exists 
(select * from student where studentName = @studentName ) 
Begin 
	select * from student where studentName = @studentName
end 
ELSE
begin 
PRINT 'Record not found'
end 
end
 select * from student
exec searchStudent 'Hi'

--2. Write a Stored procedure in SQL to give remarks for the secured marks column in the students table 
--(created in SQL Task 4) using CASE statement.


CREATE PROCEDURE remarksOnStudent 
@studentId int 
AS
BEGIN 
declare @marks int 
select @marks = SecuredMarks from student where studentId = @studentId 
select
CASE  
WHEN @marks >= 450 THEN 'Excellent' 
WHEN @marks >= 400 THEN 'Very Good' 
WHEN @marks >= 350 THEN 'Good' 
WHEN @marks >= 300 THEN 'Average' 
ELSE 'Poor Performance' 
End as Remarks
end

exec remarksOnStudent 3


--3. Show the working of Table variables, temporary table, temporary stored procedures. (Both Local and Global)

--table variable 

CREATE PROCEDURE demonstrateTableVariable 
as
begin 
declare @tableVariable table (
id int , 
name varchar(20)
)
insert into @tableVariable values 
(1,'tharnish') , 
(2,'naveen') , 
(3,'munna')
select * from @tableVariable
end

exec demonstrateTableVariable


--temporary table

--local  use #

create table #localTemp (
id int , 
name varchar(20)
)
insert into #localTemp values 
(1,'prajin') , 
(2,'surya')
select * from #localTemp


--global uses ## 

create table ##globalTemp (
id int , 
name varchar(20)
)
insert into ##globalTemp values 
(1,'prajin') , 
(2,'surya')
select * from ##globalTemp



--temporary stored procedure 

--local uses # 

CREATE PROCEDURE #localProcedure 
AS
BEGIN
PRINT 'Local temporary procedure' 
END

exec #localProcedure



--Global temporary sp 

CREATE PROCEDURE ##globalProcedure 
AS
BEGIN
PRINT 'Local temporary procedure' 
END

exec ##globalProcedure