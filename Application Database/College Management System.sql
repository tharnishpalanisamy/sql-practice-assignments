create table department (
deptId int primary key , 
deptName varchar(50)  
) 

create table student (
studentId int primary key , 
deptId int foreign key references department(deptId) , 
studentName varchar(30) , 
age int , 
gender char(1) , 
yearOfStudy int , 
phone char(10)
)

create table employees(
empId int primary key , 
empName varchar(40) , 
age int , 
experience int , 
joiningDate datetime
)

create table staff (
staffId int primary key , 
empId int foreign key references employees(empId) , 
deptId int foreign key references department(deptId) 
)

create table supportStaff(
staffId int primary key , 
empId int foreign key references employees(empId) , 
role varchar(30)
)

create table salary (
salaryId int primary key , 
empId int foreign key references employees(empId) , 
salary money 
)


create table hostelRoom(
roomNo int primary key , 
capacity int , 
roomCost money
)

create table hostel (
hostellerId int primary key , 
studentId int foreign key references student(studentId) , 
roomNo int foreign key references hostelRoom(roomNo)
)

create table sports (
sportsId int primary key , 
sportName varchar(50) 
)

create table studentSports(
studentSportsId int primary key , 
studentId int foreign key references student(studentId) , 
sportsId int foreign key references sports(sportsId)
)

create table extracurricular(
activityId int primary key , 
activityName varchar(30)
)

create table studentExtracurricular(
studentExtracurricularId int primary key , 
studentId int foreign key references student(studentId) , 
activityId int foreign key references extracurricular(activityId)
)

create table fee(
feeId int primary key , 
studentId int foreign key references student(studentID), 
amount money , 
dueDate datetime, 
status varchar(30)
)

create table course (
courseId int primary key , 
deptId int foreign key references department(deptId) , 
staffId int foreign key references staff(staffId),
courseName varchar(30) , 
courseFee money

)

create table studentCourse (
studentCourseId int primary key , 
studentId int foreign key references student(studentId) , 
courseId int foreign key references course(courseId) , 
)

create view GenerateFee
as
select s.studentId , s.studentName , s.yearOfStudy , d.deptId , 
d.deptName , c.courseId , c.courseName, c.courseFee , hr.roomNo , hr.roomCost,
c.courseFee + hr.roomCost as TotalFee
from student s
join department d on s.deptId = d.deptId 
join course c on d.deptId = c.deptId 
join studentCourse sc on sc.courseId = c.courseId
join hostel h on h.studentId = s.studentId 
join hostelRoom hr on hr.roomNo = h.roomNo


create view report 
as
select s.studentId , s.studentName , s.age , s.yearOfStudy , 
d.deptId , d.deptName , c.courseId , c.courseName , ec.activityId , ec.activityName as extraCurricularActivity , 
sports.sportsId , sports.sportName 
from student s
join department d on s.deptId = d.deptId
join staff on staff.deptId = d.deptId 
join employee e on e.empId = staff.empId 
join studentSports ss on ss.studentId = s.studentId 
join sports on sports.sportsId = ss.sportsId 
join studentExtracurricular sec on sec.studentId = s.studentId 
join extracurricular ec on ec.activityId = sec.activityId 
join studentCourse sc on sc.studentId = s.studentId 
join course c on c.courseId = sc.courseId
