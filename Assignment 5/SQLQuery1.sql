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
--4.	Demonstrate the working of convert functions to format the date and other data with example and 
--output (at least 5 examples)
