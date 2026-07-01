--Phase 10 – Indexes

-- ============================================
-- Phase 10 – Indexes Practice
-- ============================================

-- DROP TABLE
DROP TABLE IF EXISTS Employees;

-- ============================================
-- CREATE TABLE
-- ============================================

CREATE TABLE Employees
(
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Email VARCHAR(100),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    City VARCHAR(50),
    Status VARCHAR(20),
    JoinDate DATE
);

-- ============================================
-- INSERT DATA
-- ============================================

INSERT INTO Employees VALUES
(101,'Arun','arun@gmail.com','IT',65000,'Chennai','Active','2020-01-10'),
(102,'Priya','priya@gmail.com','HR',42000,'Coimbatore','Active','2021-03-15'),
(103,'Karthik','karthik@gmail.com','Finance',72000,'Madurai','Inactive','2019-07-22'),
(104,'Sneha','sneha@gmail.com','IT',58000,'Bangalore','Active','2022-05-11'),
(105,'Rahul','rahul@gmail.com','Sales',39000,'Salem','Active','2023-01-08'),
(106,'Divya','divya@gmail.com','HR',45000,'Chennai','Inactive','2020-09-17'),
(107,'Vignesh','vignesh@gmail.com','IT',91000,'Coimbatore','Active','2018-12-01'),
(108,'Meena','meena@gmail.com','Finance',68000,'Trichy','Active','2021-08-13'),
(109,'Suresh','suresh@gmail.com','Sales',47000,'Erode','Inactive','2019-11-25'),
(110,'Anitha','anitha@gmail.com','IT',76000,'Chennai','Active','2022-04-20'),
(111,'Kumar','kumar@gmail.com','Finance',54000,'Madurai','Active','2020-02-18'),
(112,'Ravi','ravi@gmail.com','HR',43000,'Salem','Inactive','2023-06-09'),
(113,'Harini','harini@gmail.com','IT',99000,'Bangalore','Active','2018-05-14'),
(114,'Ajay','ajay@gmail.com','Sales',41000,'Trichy','Active','2021-09-27'),
(115,'Nisha','nisha@gmail.com','Finance',64000,'Chennai','Inactive','2022-12-05'),
(116,'Manoj','manoj@gmail.com','IT',70000,'Coimbatore','Active','2020-07-30'),
(117,'Keerthi','keerthi@gmail.com','HR',46000,'Madurai','Active','2019-03-12'),
(118,'Gokul','gokul@gmail.com','Sales',50000,'Erode','Inactive','2021-01-01'),
(119,'Ashwin','ashwin@gmail.com','Finance',81000,'Bangalore','Active','2018-10-10'),
(120,'Deepa','deepa@gmail.com','IT',87000,'Chennai','Active','2023-02-14');
--Q60

--Create clustered index.

drop index PK__Employee__AF2DBA7956E36BA4 

Create clustered index Email_index 
on employees(email)


--Q61

--Create non-clustered index.
create nonclustered index city_index
on Employees(City)

--Q62

--Create filtered index.
create nonclustered index active_employees_index 
on employees(status) 
where status = 'Active' 
--Q63

--How to check index usage?

--Q64

--When does index hurt performance?

--Q65

--Clustered vs Non-Clustered.