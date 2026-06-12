--Phase 9 – Views
-- Create Departments Table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL,
    Location VARCHAR(50)
);
-- Create Employees Table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Salary DECIMAL(10,2),
    HireDate DATE,
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Insert Sample Data
INSERT INTO Departments VALUES 
(10, 'HR', 'New York'),
(20, 'IT', 'San Francisco'),
(30, 'Sales', 'Chicago');

INSERT INTO Employees VALUES 
(101, 'Alice', 'Smith', 75000.00, '2022-01-15', 10),
(102, 'Bob', 'Jones', 90000.00, '2021-06-20', 20),
(103, 'Charlie', 'Brown', 60000.00, '2023-03-10', 30),
(104, 'David', 'Green', 95000.00, '2020-11-05', 20);


--Q55

--Create simple view.

create view temp  as
select * from employees

select * from temp 

insert into temp values (105 , 'virat' , 'kohli' , 8000000 , GETDATE() , 30)
--Q56

--Create join view.

CREATE VIEW 
joinView 
as
select e.EmployeeID , e.FirstName , e.Salary , d.DepartmentID , d.DepartmentName
from employees e 
join departments d 
on e.DepartmentID = d.DepartmentID 

--Q57

--Create complex view.

CREATE VIEW COMPVIEW 
AS
SELECT E.EmployeeID , E.FirstName , E.Salary , D.DEPARTMENTID ,D.DepartmentName , AVG(E.SALARY) OVER(PARTITION BY D.DEPARTMENTID ) AS AVERAGESALARY 
FROM Employees E 
JOIN Departments D 
ON E.DepartmentID = D.DepartmentID 

SELECT * FROM COMPVIEW

--Q58

--Update data through view.
insert into temp values (106 , 'Tharnish' , 'Palanisamy' , 10000000 , GETDATE() , 20) 
select * from temp 




--Q59

--When is a view updatable?

--view is updatable only when the view is simple and it has all the columns that are not null in the original table 
-- in that case we can update the table and its not updatable when the view complex or does not have all the columns 
-- or has complex operations like group by , joins , subqueires etc... 