--the working of Primary and Foreign key for the tables in the attached image. Show 


create table department(
deptId int primary key , 
department varchar(50) ) ; 

create table address(
addressId int primary key , 
city varchar(30) , 
pincode int ) ; 

create table employee(
id int primary key , 
name varchar(30) , 
role varchar(50) , 
deptId int foreign key references department(deptId) ,  
mobile varchar(10) , 
addressId int foreign key references address(addressId), 
); 

-- Department Table
INSERT INTO department VALUES
(1, 'HR'),
(2, 'Finance'),
(3, 'Developer'),
(4, 'Testing'),
(5, 'Support');


-- Address Table
INSERT INTO address VALUES
(101, 'Chennai', 600001),
(102, 'Coimbatore', 641001),
(103, 'Bangalore', 560001),
(104, 'Hyderabad', 500001),
(105, 'Mumbai', 400001);


-- Employee Table
INSERT INTO employee VALUES
(1, 'Tharnish', 'Full Stack Developer', 3, '9876543210', 101),

(2, 'Sanjay', 'HR Manager', 1, '9123456780', 102),

(3, 'Vishal', 'Tester', 4, '9988776655', 103),

(4, 'Shawn', 'Finance Analyst', 2, '9090909090', 104),

(5, 'Midhun', 'Support Engineer', 5, '9012345678', 105);


--relationship 
select * from employee as e inner join department as d on e.deptId = d.deptId inner join address as a on e.addressId = a.addressId ; 