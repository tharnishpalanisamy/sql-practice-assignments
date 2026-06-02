create table attender(
attenderId int primary key , 
name varchar(30) , 
age int , 
gender char(1) ,
relation varchar(30) , 
phone char(10) 
)

create table disease(
diseaseId int primary key , 
diseaseName varchar(50) , 
description varchar(100) , 
treatmentCost money 
)

create table employee (
empId int primary key , 
empName varchar(30) , 
salary money , 
joiningDate datetime
)

create table specialization(
specializationId int primary key , 
specializationName varchar(50)
) 


create table doctor (
doctorId int primary key , 
empId int foreign key references employee(empId) , 
specializationId int foreign key references specialization(specializationID) 
)

create table supportStaff(
staffId int primary key , 
empId int foreign key references employee(empId) ,
role varchar(50) 
) 



create table patient (
patientId int primary key , 
patientName varchar(30) , 
attenderId int foreign key references attender(attenderId) ,
age int , 
gender char(1) , 
maritalStatus char(1) , 
phone char(10) , 
)

create table room(
roomId int primary key , 
roomType varchar(30) , 
cost money
)


create table helpingStaff(
staffId int primary key , 
empId int foreign key references employee(empId) , 
roomId int foreign key references room(roomId) , 
role varchar(50) 
)


create table admission(
admissionId int primary key , 
patientId int foreign key references patient(patientId) , 
doctorId int foreign key references doctor(doctorId) , 
roomId int foreign key references room(roomId) , 
admissionDate datetime , 
dischargeDate datetime
)

create table patientDisease(
patientDieaseId int primary key , 
patientId int foreign key references patient(patientId) , 
diseaseId int foreign key references disease(diseaseId) , 
)

create table bill(
billId int primary key,
admissionId int foreign key references admission(admissionId),
roomCharge money,
treatmentCharge money,
totalAmount money,
billDate datetime
)

create table bill(
billId int primary key,
admissionId int foreign key references admission(admissionId),
billDate datetime
)

create view generateBill 
as
select p.patientId , p.patientName , b.billId , r.cost as roomCost,
sum(d.treatmentCost) as treatmentCost , r.cost + sum(d.treatmentCost) as totalAmount 
from bill b 
join admission a on b.admissionID = a.admissionId 
join patient p on p.patientId = a.patientId 
join room r on r.roomId = a.roomId 
join patientDisease pd on p.patientId = pd.patientId 
join disease d on d.diseaseId = pd.diseaseId 
group by d.treatmentCost , p.patientName , p.patientId , b.billId , r.cost
