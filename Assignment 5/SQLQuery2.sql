--1.	Create TraineeMain table with Id, TraineeName, CourseName, MarksScored, and Grade fields. Insert at least 5 records
--excluding Grade field. Update the value of Grade based on the MarkScored using ‘case’ option. If MarkScored is >= 95,
--Grade is A+, If MarkScored is >= 90, Grade is A, If MarkScored is >= 85, Grade is B+, If MarkScored is >= 80, Grade is B,
--If MarkScored is >= 70, Grade is C, If MarkScored is >= 60, Grade is D, If MarkScored is >= 50, Grade is E, else F.  Create
--TraineeCurrent table with Id, TraineeName, CourseName, MarksScored, and Grade fields. Insert and Update the date like above 
--conditions, where as  few records are similar with TraineeMain table and others are not. Merge the two table records by Update/
--Insert/Delete options and give the output with the reason explained.




CREATE table traineeMain (
traineeId int , 
traineeName varchar(30) , 
courseName varchar(30) , 
marksScored varchar(30) , 
grade varchar(30) 

)

INSERT INTO traineeMain(traineeId , traineeName , courseName , marksScored) VALUES
(1, 'Arun Kumar', 'Python', '85'),
(2, 'Priya Sharma', 'Java', '92'),
(3, 'Rahul Verma', 'SQL', '78'),
(4, 'Sneha Reddy', 'Full Stack', '88'),
(5, 'Karan Patel', 'Data Science', '95'),
(6, 'Meena Iyer', 'Python', '81'),
(7, 'Vikram Singh', 'Java', '76'),
(8, 'Anjali Das', 'SQL', '89'),
(9, 'Rohit Jain', 'Full Stack', '84'),
(10, 'Divya Nair', 'Data Science', '91');

declare @traineeId int 
declare @marks int 
DECLARE traineeCursor CURSOR FOR 
select traineeId  , marksScored 
from traineeMain 

OPEN traineeCursor 

FETCH next from traineeCursor into @traineeId , @marks ; 

while @@FETCH_STATUS = 0 
BEGIN 
	update traineeMain set grade = CASE 
	WHEN @marks >= 95 THEN 'A+' 
	WHEN @marks >= 90 THEN 'A' 
	WHEN @marks >= 85 THEN 'B+'
	WHEN @marks >= 80 THEN 'B'
	WHEN @marks >= 70 THEN 'C'
	WHEN @marks >= 60 THEN 'D'
	WHEN @marks >= 50 THEN 'E' 
	ELSE 'F' 
	END
	where traineeId = @traineeId

	FETCH NEXT FROM traineeCursor INTO @traineeId, @marks; 

END

close traineeCursor 
deallocate traineeCursor

select * from traineeMain

create table traineeCurrent (
traineeId int , 
traineeName varchar(30) , 
courseName varchar(30) , 
marksScored varchar(30) , 
grade varchar(30) 
)

INSERT INTO traineeCurrent
(traineeId, traineeName, courseName, marksScored)
VALUES
(1, 'Arun Kumar', 'Python', '85'),
(2, 'Priya Sharma', 'Java', '92'),
(3, 'Rahul Verma', 'SQL', '78'),
(4, 'Sneha Reddy', 'Full Stack', '88'),
(5, 'Karan Patel', 'Data Science', '95'),

(10, 'Aakash Roy', 'React', '87'),
(11, 'Neha Gupta', 'Python', '93'),
(12, 'Suresh Mani', 'SQL', '74'),
(13, 'Pooja Mehta', 'Java', '82'),
(14, 'Manoj Kumar', 'Data Science', '90'),
(15, 'Kavya Sri', 'Full Stack', '79');

update traineeCurrent set grade = CASE 
	WHEN marksScored >= 95 THEN 'A+' 
	WHEN marksScored >= 90 THEN 'A' 
	WHEN marksScored >= 85 THEN 'B+'
	WHEN marksScored >= 80 THEN 'B'
	WHEN marksScored >= 70 THEN 'C'
	WHEN marksScored >= 60 THEN 'D'
	WHEN marksScored >= 50 THEN 'E' 
	ELSE 'F' 
	END

select * from traineeCurrent

MERGE traineeMain as tm using traineeCurrent as tc 
on tm.traineeId = tc.traineeId 
when MATCHED THEN 
UPDATE SET 
tm.traineeID = tc.traineeID  , 
tm.traineeName = tc.traineeName , 
tm.courseName = tc.courseName , 
tm.marksScored = tc.marksScored , 
tm.grade = tc.grade 

WHEN NOT MATCHED BY Target then 
INSERT (traineeId, traineeName, courseName, marksScored, grade)
    VALUES (
        TC.traineeId,
        TC.traineeName,
        TC.courseName,
        TC.marksScored,
        TC.grade
    )
WHEN Not Matched by source THEN DELETE ; 

select * from traineeCurrent 
select * from traineeMain




--2.	Create and Employee table with EmpId, EmployeeName, DateofJoin, Department, BasicSalary, DA, HRA, FA, PF, TAX, GrossSalary,
--Deductions, NetSalary fields. Insert at least 10 employee records up to the BasicSalary fields using AI support and other details
--are to be calculated and updated in the table using the cursors. The procedure for calculation is given below: If BasicSalary is 
--above 20000, da is 58.5% of BasicSalary, hra is 15% of BasicSalary, pf is 20% of BasicSalary and tax is 17% of BasicSalary
--If BasicSalary is above 15000, da is 46% of BasicSalary, hra is 12% of BasicSalary, pf is 15% of BasicSalary and tax is 12% of BasicSalary
--Otherwise da is 42.5% of BasicSalary, hra is rs.1500, pf is 10% of BasicSalary and no tax. FA is fixed as 5000 for all the employees in Tech
--and Sales department and 3000 for HR and accounts department.
--GrossSalary = BasicSalary + da + hra + fa, deduction = pf + tax
--NetSalary = GrossSalary – deduction
--Update these calculated values to the record using cursor


CREATE Table employee(
empId int primary key , 
empName varchar(30) , 
joiningDate datetime , 
department varchar(30) , 
BasicSalary decimal(10,2) , 
da decimal(10,2) , 
hra decimal(10,2) , 
fa decimal(10,2) , 
pf decimal(10,2) , 
tax decimal(10,2) , 
grossSalary decimal(10,2) , 
deductions decimal(10,2) , 
netSalary decimal(10,2)
)

INSERT INTO employee
(empId, empName, joiningDate, department, BasicSalary)
VALUES
(1, 'Arun Kumar', '2022-01-15', 'HR', 30000),

(2, 'Priya Sharma', '2021-03-20', 'tech', 45000),

(3, 'Rahul Verma', '2020-07-10', 'tech', 40000),

(4, 'Sneha Reddy', '2023-02-01', 'sales', 35000),

(5, 'Karan Patel', '2019-11-25', 'tech', 55000),

(6, 'Meena Iyer', '2022-05-18', 'HR', 32000),

(7, 'Vikram Singh', '2021-08-09', 'accounts', 38000),

(8, 'Anjali Das', '2020-12-30', 'accounts', 42000),

(9, 'Rohit Jain', '2023-04-12', 'tech', 47000),

(10, 'Divya Nair', '2018-06-22', 'sales', 60000),

(11, 'Aakash Roy', '2022-09-14', 'Sales', 34000),

(12, 'Neha Gupta', '2021-10-05', 'HR', 50000),

(13, 'Suresh Mani', '2020-01-19', 'accounts', 36000),

(14, 'Pooja Mehta', '2019-07-28', 'HR', 48000),

(15, 'Manoj Kumar', '2023-03-11', 'HR', 31000);

DECLARE @basicSalary decimal(10,2) 
DECLARE @empId int 

DECLARE salaryCursor CURSOR FOR 
select empId, basicSalary from employee

OPEN salaryCursor

FETCH NEXT FROM salaryCursor INTO @empId, @basicSalary

WHILE @@FETCH_STATUS = 0  
BEGIN 
update employee set

da = CASE 
WHEN BasicSalary >= 20000 THEN  BasicSalary * 0.585 
WHEN BasicSalary >= 15000 THEN  BasicSalary * 0.46
ELSE 0 
END , 


hra = CASE 
WHEN BasicSalary >= 20000 THEN  BasicSalary * 0.15 
WHEN BasicSalary >= 15000 THEN  BasicSalary * 0.12
ELSE 0 
END 
 , 
pf = CASE 
WHEN BasicSalary >= 20000 THEN  BasicSalary * 0.2 
WHEN BasicSalary >= 15000 THEN  BasicSalary * 0.1
ELSE 0 
END  , 


tax = CASE 
WHEN BasicSalary >= 20000 THEN  BasicSalary * 0.17 
ELSE 0 
END  , 


fa = case 
WHEN department in ('tech','sales') THEN 5000 
WHEN department in ('HR','accounts') THEN 3000 
ELSE 0 
END , 


grossSalary = BasicSalary + CASE 
WHEN BasicSalary >= 20000 THEN  BasicSalary * 0.585 
WHEN BasicSalary >= 15000 THEN  BasicSalary * 0.46
ELSE 0 
END  + CASE 
WHEN BasicSalary >= 20000 THEN  BasicSalary * 0.15 
WHEN BasicSalary >= 15000 THEN  BasicSalary * 0.12
ELSE 0 
END  + case 
WHEN department in ('tech','sales') THEN 5000 
WHEN department in ('HR','accounts') THEN 3000 
ELSE 0 
END  , 


deductions =  CASE 
WHEN BasicSalary >= 20000 THEN  BasicSalary * 0.2 
WHEN BasicSalary >= 15000 THEN  BasicSalary * 0.1
ELSE 0 
END   + CASE 
WHEN BasicSalary >= 20000 THEN  BasicSalary * 0.17 
ELSE 0 
END , 


netSalary = BasicSalary + CASE 
WHEN BasicSalary >= 20000 THEN  BasicSalary * 0.585 
WHEN BasicSalary >= 15000 THEN  BasicSalary * 0.46
ELSE 0 
END  + CASE 
WHEN BasicSalary >= 20000 THEN  BasicSalary * 0.15 
WHEN BasicSalary >= 15000 THEN  BasicSalary * 0.12
ELSE 0 
END  + case 
WHEN department in ('tech','sales') THEN 5000 
WHEN department in ('HR','accounts') THEN 3000 
ELSE 0 
END  - CASE 
WHEN BasicSalary >= 20000 THEN  BasicSalary * 0.2 
WHEN BasicSalary >= 15000 THEN  BasicSalary * 0.1
ELSE 0 
END   + CASE 
WHEN BasicSalary >= 20000 THEN  BasicSalary * 0.17 
ELSE 0 
END


where empId = @empId

FETCH NEXT FROM salaryCursor INTO @empId, @basicSalary
END
close salaryCursor 
deallocate SalaryCursor 



---- 3.	Insert at least 5 records excluding Grade field. Use the Cursor to update the Grade of the trainee after 
--calculating the Grade value using if condition.

select * from employee

DECLARE @traineeId1 INT;
DECLARE @marks1 INT;
DECLARE @grade VARCHAR(10);

-- Cursor
DECLARE traineeCursor CURSOR FOR
SELECT traineeId, CAST(marksScored AS INT)
FROM traineeMain;

OPEN traineeCursor;

FETCH NEXT FROM traineeCursor
INTO @traineeId1, @marks1;

WHILE @@FETCH_STATUS = 0
BEGIN

    IF @marks1 >= 95
        SET @grade = 'A+';

    ELSE IF @marks1 >= 90
        SET @grade = 'A';

    ELSE IF @marks1 >= 85
        SET @grade = 'B+';

    ELSE IF @marks1 >= 80
        SET @grade = 'B';

    ELSE IF @marks1>= 70
        SET @grade = 'C';

    ELSE IF @marks1 >= 60
        SET @grade = 'D';

    ELSE IF @marks1 >= 50
        SET @grade = 'E';

    ELSE
        SET @grade = 'F';

    -- Update grade
    UPDATE traineeMain
    SET grade = @grade
    WHERE traineeId = @traineeId1;

    FETCH NEXT FROM traineeCursor
    INTO @traineeId1, @marks1;

END;

CLOSE traineeCursor;
DEALLOCATE traineeCursor;

SELECT * FROM traineeMain;


--4.	Write two different scalar valued functions for the existing table and execute it.

CREATE TABLE StudentMarks
(
    studentId INT PRIMARY KEY,
    studentName VARCHAR(50),
    tamil INT,
    english INT,
    maths INT,
    science INT,
    social INT
);

INSERT INTO StudentMarks
(studentId, studentName, tamil, english, maths, science, social)
VALUES
(1, 'Arun', 85, 78, 92, 88, 80),
(2, 'Priya', 90, 95, 89, 91, 87),
(3, 'Kavin', 70, 65, 72, 68, 74),
(4, 'Divya', 88, 84, 90, 86, 92),
(5, 'Rahul', 60, 72, 58, 64, 69),
(6, 'Sneha', 93, 89, 96, 94, 91),
(7, 'Vikram', 76, 81, 79, 73, 77),
(8, 'Meena', 82, 88, 85, 90, 84),
(9, 'Ajay', 67, 70, 65, 72, 68),
(10, 'Harini', 95, 97, 99, 96, 98);

SELECT * FROM StudentMarks;

CREATE FUNCTION calculatePercentage (
@studentId int
)
returns decimal(10,2) 
as 
begin
declare @mark1 int 
declare @mark2 int 
declare @mark3 int 
declare @mark4 int 
declare @mark5 int 

declare @percentage decimal(10,2) 

select @mark1 = tamil, @mark2 = english,@mark3 = maths, @mark4 = science,@mark5 = social from StudentMarks where studentId = @studentId

set @percentage = (@mark1+@mark2 + @mark3 + @mark4 + @mark5) / 5 

return @percentage
end

select dbo.calculatePercentage(7) 


CREATE FUNCTION CalculateTotal (
@studentId int
)
returns decimal(10,2) 
as 
begin
declare @mark1 int 
declare @mark2 int 
declare @mark3 int 
declare @mark4 int 
declare @mark5 int 

declare @total decimal(10,2) 

select @mark1 = tamil, @mark2 = english,@mark3 = maths, @mark4 = science,@mark5 = social from StudentMarks where studentId = @studentId

set @total = (@mark1+@mark2 + @mark3 + @mark4 + @mark5) 

return @total
end

select dbo.CalculateTotal(5)


--5.	Write two different table valued functions for the existing table and execute it.

CREATE FUNCTION getHigherMathValue (
@maths int
) 
returns table 
as
return (
select * from StudentMarks where maths >= @maths
)

select * from dbo.getHigherMathValue(60)

CREATE FUNCTION studentsAboveTotal(
@total int
)
returns table 
as
return (
select * from StudentMarks where (english+tamil+maths+science+social) >= @total
)

select * from dbo.studentsAboveTotal(450)


