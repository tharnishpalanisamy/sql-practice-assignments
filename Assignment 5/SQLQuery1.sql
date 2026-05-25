--Task – 1
--1.	Demonstrate the working of at least 20 string functions with example and output 

CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Department VARCHAR(50),
    Email VARCHAR(100),
    City VARCHAR(50),
    Salary DECIMAL(10,2),
    Phone VARCHAR(20)
);

INSERT INTO Employees VALUES
(1, 'Arun Kumar', 'HR', 'arun@gmail.com', 'Chennai', 45000, '9876543210'),

(2, 'Priya Sharma', 'Finance', 'priya@yahoo.com', 'Coimbatore', 52000, '9123456780'),

(3, 'Rahul Verma', 'IT', 'rahul@outlook.com', 'Bangalore', 60000, '9988776655'),

(4, 'Sneha Reddy', 'Marketing', 'sneha@gmail.com', 'Hyderabad', 48000, '9012345678'),

(5, 'Karan Patel', 'Sales', 'karan@gmail.com', 'Mumbai', 55000, '9090909090'),

(6, 'Meena Iyer', 'HR', 'meena@yahoo.com', 'Madurai', 47000, '9345678901'),

(7, 'Vikram Singh', 'IT', 'vikram@gmail.com', 'Delhi', 72000, '9871234567'),

(8, 'Anjali Das', 'Finance', 'anjali@outlook.com', 'Kolkata', 51000, '9123098765'),

(9, 'Rohit Jain', 'Sales', 'rohit@gmail.com', 'Pune', 53000, '9988001122'),

(10, 'Divya Nair', 'Marketing', 'divya@yahoo.com', 'Kochi', 49000, '9876501234'),

(11, 'Suresh Babu', 'IT', 'suresh@gmail.com', 'Chennai', 68000, '9001122334'),

(12, 'Kavya Rao', 'HR', 'kavya@outlook.com', 'Mysore', 46000, '9112233445'),

(13, 'Ajay Mehta', 'Finance', 'ajay@gmail.com', 'Ahmedabad', 58000, '9223344556'),

(14, 'Pooja Singh', 'Sales', 'pooja@yahoo.com', 'Jaipur', 50000, '9334455667'),

(15, 'Nitin Joshi', 'Marketing', 'nitin@gmail.com', 'Nagpur', 47000, '9445566778'),

(16, 'Lakshmi Devi', 'IT', 'lakshmi@gmail.com', 'Trichy', 75000, '9556677889'),

(17, 'Manoj Kumar', 'Finance', 'manoj@outlook.com', 'Salem', 54000, '9667788990'),

(18, 'Neha Kapoor', 'HR', 'neha@gmail.com', 'Noida', 49000, '9778899001'),

(19, 'Harish Raj', 'Sales', 'harish@yahoo.com', 'Erode', 52000, '9889900112'),

(20, 'Aarthi Bala', 'Marketing', 'aarthi@gmail.com', 'Vellore', 51000, '9990011223');

--string functions 
--upper
select UPPER(FullName) as NameInCap from Employees

--2.
select LOWER(FullName) as NameInLow from Employees 
--3 
select LEN(fullName) as length from Employees 

--4 
select FullName from Employees where FullName like 'A%'

select FullName from Employees where FullName like '%A%'

select FullName from Employees where FullName like '%A' 

--5 
select SUBSTRING(fullName,1,3) as first3Chars from Employees

--6 
select LEFT(fullName,4) as charsFromLeft from Employees

--7 
select RIGHT(fullName,4) as charsFromRight from Employees

--8
declare @varWithLeftSpace varchar(40) 
set @varWithLeftSpace = '          this variable has space on left' 
select LTRIM(@varWithLeftSpace) as leftTrimmed

--9 
declare @varWithRightSpace varchar(40) 
set @varWithRightSpace = 'this variable has space on Right           ' 
select RTRIM(@varWithRightSpace) as rightTrimmed

--10 
declare @varWithSpaces varchar(40) 
set @varWithSpaces = '                this variable has space on Both Sides           ' 
select TRIM(@varWithSpaces) as Trimmed

--11 
select REPLACE(FullName,'Arun','Akash') from Employees where FullName like 'Arun%'

--12 

select empId,  LOWER(REVERSE(fullName)) from Employees

--13 
select CHARINDEX('Arun',fullName) from Employees where empId = 1

--14 
select CONCAT('Mr/Mrs' ,' ', FullName) from Employees

--15 
select FORMAT(GETDATE(),'dd-MMMM-yyyy')

--16 

select STUFF('Arun',3,2,'ya' ) from Employees where empId = 1 

--17 

select REPLICATE('repeat',4) 

--18 
SELECT value
FROM STRING_SPLIT('Apple,Banana,Mango', ',');

--19 
select TRANSLATE('Arun Kumar' , 'Arun' , 'akay') from Employees where EmpID = 1 

--20 

select 'Hello'+ SPACE(2) + fullName as Greeting from Employees


--2.	Demonstrate the working of at least 20 mathematical functions with example and output

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100),
    Tamil INT,
    English INT,
    Maths INT,
    Science INT,
    Social INT
);

INSERT INTO Students VALUES
(1, 'Arun Kumar', 78, 85, 90, 88, 76),
(2, 'Priya Sharma', 92, 89, 95, 91, 90),
(3, 'Rahul Verma', 65, 70, 68, 72, 66),
(4, 'Sneha Reddy', 88, 84, 79, 90, 85),
(5, 'Karan Patel', 55, 60, 58, 62, 57),
(6, 'Meena Iyer', 81, 86, 88, 84, 80),
(7, 'Vikram Singh', 95, 93, 97, 96, 94),
(8, 'Anjali Das', 73, 75, 70, 78, 72),
(9, 'Rohit Jain', 68, 64, 66, 70, 69),
(10, 'Divya Nair', 85, 87, 89, 90, 88),
(11, 'Suresh Babu', 58, 62, 61, 65, 60),
(12, 'Kavya Rao', 91, 90, 92, 93, 94),
(13, 'Ajay Mehta', 77, 79, 81, 80, 78),
(14, 'Pooja Singh', 69, 72, 74, 71, 73),
(15, 'Nitin Joshi', 83, 85, 82, 84, 86),
(16, 'Lakshmi Devi', 96, 98, 99, 97, 95),
(17, 'Manoj Kumar', 62, 67, 65, 64, 66),
(18, 'Neha Kapoor', 87, 89, 90, 88, 86),
(19, 'Harish Raj', 74, 76, 78, 75, 77),
(20, 'Aarthi Bala', 80, 82, 84, 83, 81);


--1 
select studentId  , studentName, (tamil+english+science+social + maths) as total from Students

--2
select StudentID , StudentName , (tamil+english+science+social + maths)/5.0 as average from students 

--3 
select StudentID , StudentName , CEILING((tamil+english+science+social + maths)/5.0) as ceilingAverage from students 

--4 
select StudentID , StudentName , FLOOR((tamil+english+science+social + maths)/5.0) as floorAverage from students 

--5 
select StudentID , StudentName , Round((tamil+english+science+social + maths)/5.0,2) as roundedAverage from students 

--6 
select sum(english) as totalMarksInEnglish from Students

--7 
select max(tamil) as maxMarkInTamil from Students

--8
select Min(maths) as minMarkInMaths from Students

--9 
select POWER(100,3)

--10 
select Round(SQRT(8),2) 

--11 
select RAND() 
--from 1 - 10 
select floor(RAND() * 10 + 1 )

--12 
select ABS(200-400) 

--13 

select SIGN(-100) , sign(100) , sign(0)

--14 

select PI() as PiValue

--15 
SELECT StudentName,EXP(2) AS ExponentialValue FROM Students;

--16 

SELECT StudentName, LOG(Maths) AS LogValue FROM Students;

--17 

select (100%2) as moduloOperator 

--18 
select SIN(Science) from students
select TAN(Science) from students
select COS(Science) from students
select COT(Science) from students


--19 

select count(*) as studentCount from students

--20 

SELECT  DEGREES(PI()) AS DegreeValue 



--3.	 Demonstrate the working of at least 30 date functions with example and output

CREATE TABLE EmployeeAttendance (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(100),
    Department VARCHAR(50),
    JoinDate DATE,
    BirthDate DATE,
    LoginDateTime DATETIME,
    Salary DECIMAL(10,2)
);

INSERT INTO EmployeeAttendance VALUES
(1, 'Arun Kumar', 'HR', '2020-01-15', '1998-05-12', '2026-05-01 09:15:20', 45000),

(2, 'Priya Sharma', 'Finance', '2019-03-10', '1997-08-22', '2026-05-02 08:45:10', 52000),

(3, 'Rahul Verma', 'IT', '2021-06-25', '1999-11-05', '2026-05-03 09:05:30', 60000),

(4, 'Sneha Reddy', 'Marketing', '2018-07-18', '1996-04-17', '2026-05-04 10:10:15', 48000),

(5, 'Karan Patel', 'Sales', '2022-02-12', '2000-09-09', '2026-05-05 09:25:40', 55000),

(6, 'Meena Iyer', 'HR', '2020-09-14', '1998-12-30', '2026-05-06 08:55:22', 47000),

(7, 'Vikram Singh', 'IT', '2017-11-20', '1995-03-14', '2026-05-07 09:40:55', 72000),

(8, 'Anjali Das', 'Finance', '2021-01-08', '1999-06-18', '2026-05-08 10:00:00', 51000),

(9, 'Rohit Jain', 'Sales', '2019-08-27', '1997-01-25', '2026-05-09 09:35:11', 53000),

(10, 'Divya Nair', 'Marketing', '2022-04-19', '2001-07-11', '2026-05-10 08:50:45', 49000),

(11, 'Suresh Babu', 'IT', '2018-12-01', '1996-10-08', '2026-05-11 09:20:19', 68000),

(12, 'Kavya Rao', 'HR', '2023-01-16', '2002-02-15', '2026-05-12 09:05:50', 46000),

(13, 'Ajay Mehta', 'Finance', '2020-06-30', '1998-09-27', '2026-05-13 10:12:35', 58000),

(14, 'Pooja Singh', 'Sales', '2019-10-09', '1997-05-19', '2026-05-14 09:48:41', 50000),

(15, 'Nitin Joshi', 'Marketing', '2021-05-21', '1999-08-03', '2026-05-15 08:58:29', 47000),

(16, 'Lakshmi Devi', 'IT', '2017-03-17', '1995-12-01', '2026-05-16 09:11:16', 75000),

(17, 'Manoj Kumar', 'Finance', '2022-07-11', '2000-04-28', '2026-05-17 09:59:59', 54000),

(18, 'Neha Kapoor', 'HR', '2020-11-23', '1998-06-09', '2026-05-18 10:07:44', 49000),

(19, 'Harish Raj', 'Sales', '2018-02-05', '1996-01-13', '2026-05-19 09:18:52', 52000),

(20, 'Aarthi Bala', 'Marketing', '2023-03-29', '2002-10-21', '2026-05-20 08:42:37', 51000),

(21, 'Deepak Roy', 'IT', '2019-09-13', '1997-03-07', '2026-05-21 09:33:08', 64000),

(22, 'Swathi Menon', 'HR', '2021-12-24', '2000-11-16', '2026-05-22 10:15:45', 47000),

(23, 'Ganesh Kumar', 'Finance', '2018-05-02', '1996-07-24', '2026-05-23 08:49:13', 59000),

(24, 'Riya Sharma', 'Sales', '2022-08-18', '2001-02-02', '2026-05-24 09:27:26', 53000),

(25, 'Sanjay Patel', 'Marketing', '2020-10-31', '1998-09-14', '2026-05-25 09:55:55', 50000);

--1
select GETDATE() as currentDate

--2 
select FORMAT(GETDATE(),'dd-MMMM-yyyy') as formatedDate 

--3 
select CURRENT_TIMESTAMP as currentTimeStamp

--4 
select DAY(GETDATE()) as Day
select MONTH(GETDATE()) as Month 
select YEAR(GETDATE())  as Year

--5 
select DATEPART(DAY,GETDATE()) as Day
select DATEPART(MONTH,GETDATE()) as Month
select DATEPART(YEAR,GETDATE()) as Year

--6 
select DATENAME(DAY, GETDATE()) AS Day;
select DATENAME(MONTH, GETDATE()) AS Month;
select DATENAME(YEAR, GETDATE()) AS year;

--7
select DATEADD(DAY, 5, '2026-05-25') AS dayPlusFive;
select DATEADD(MONTH, 5, '2026-05-25') AS monthPlusFive;
select DATEADD(Year, 5, '2026-05-25') AS yearPlusFive;

--8
select DATEDIFF(DAY , '2026-03-16','2026-05-25' ) joiningDate 
select DATEDIFF(Month , '2026-03-16','2026-05-25' ) joiningMonth 
select DATEDIFF(Year , '2026-03-16','2026-05-25' ) joiningYear


--9 
select EOMONTH('2026-05-25') as lastDayOfMonth

--10 
select ISDATE('2026')
select ISDATE('Not a date')


--11 
select CAST(GETDATE() as varchar)

--12
select CONVERT(varchar , GETDATE())
select CONVERT(DATE , GETDATE())



--13 

select TIMEFROMPARTS(8, 30, 45, 0, 0) AS time;

--14 
select DATETIMEFROMPARTS(2026,12,15,12,45,30,0) as dateTime

--15 

select SWITCHOFFSET('2026-05-25 10:30:00 +05:30', '-04:00') AS ChangedOffset; 

--16 
select TODATETIMEOFFSET('2026-05-25 04:30:00' , '+05:30') setTimeZone


--17 

declare @dueDate datetime 
set @dueDate = '2026-04-10'

select IIF(GETDATE() > @dueDate , 'OverDue' , 'Pending') as status

--18 
select GETUTCDATE() AS UTCDateTime;

--19 
select CURRENT_TIMEZONE() AS TimeZoneName; 

--20 
select SYSDATETIMEOFFSET() AS SystemDateTimeOffset;

--21
select SMALLDATETIMEFROMPARTS(2026,12,20,10,30) as smallSate


--22 
select DATE_BUCKET(minute, 5, CAST(JoinDate AS DATETIME2)) 
FROM EmployeeAttendance;

--23
select DATETRUNC(MONTH, '2026-05-25 14:45:30') AS MonthStart;

--24
SELECT EmpName , CHOOSE(MONTH(BirthDate),'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec') AS BirthMonth
FROM EmployeeAttendance;





--4.	Demonstrate the working of convert functions to format the date and other data with example and 
--output (at least 5 examples)

select FORMAT(GETDATE() , 'dd-MM-yyyy') as formattedDate

select FORMAT(GETDATE() , 'dd-MMMM-yyyy') as formattedDate

select FORMAT(GETDATE() , 'dd-MMM-yyyy') as formattedDate


select CONVERT(varchar , GETDATE()) as convertedDate

select CONVERT(DATE , GETDATE())  as convertedDate

select CAST(GETDATE() as varchar)