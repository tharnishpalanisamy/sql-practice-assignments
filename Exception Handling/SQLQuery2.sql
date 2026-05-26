CREATE TABLE Employees
(
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(100),
    Email VARCHAR(100) UNIQUE,
    Salary MONEY
)


CREATE TABLE ErrorLog
(
    LogID INT IDENTITY,
    ErrorNumber INT,
    ErrorMessage VARCHAR(500),
    ErrorDate DATETIME DEFAULT GETDATE()
)


INSERT INTO Employees (EmpID, EmpName, Email, Salary)
VALUES
(1, 'Arun Kumar', 'arun@gmail.com', 35000),
(2, 'Priya Sharma', 'priya@gmail.com', 42000),
(3, 'Kavin Raj', 'kavin@gmail.com', 38000),
(4, 'Divya Lakshmi', 'divya@gmail.com', 50000),
(5, 'Rahul Verma', 'rahul@gmail.com', 31000),
(6, 'Sneha Reddy', 'sneha@gmail.com', 47000),
(7, 'Vikram Singh', 'vikram@gmail.com', 39000),
(8, 'Meena Nair', 'meena@gmail.com', 41000),
(9, 'Ajay Patel', 'ajay@gmail.com', 29000),
(10, 'Harini Devi', 'harini@gmail.com', 55000),
(11, 'Sanjay Kumar', 'sanjay@gmail.com', 36000),
(12, 'Deepika Rao', 'deepika@gmail.com', 44000),
(13, 'Naveen Babu', 'naveen@gmail.com', 33000),
(14, 'Lavanya S', 'lavanya@gmail.com', 52000),
(15, 'Mohit Jain', 'mohit@gmail.com', 37000),
(16, 'Ritika Mehta', 'ritika@gmail.com', 46000),
(17, 'Anand Krish', 'anand@gmail.com', 40500),
(18, 'Keerthana P', 'keerthana@gmail.com', 49000),
(19, 'Suresh Mani', 'suresh@gmail.com', 32000),
(20, 'Pooja Yadav', 'pooja@gmail.com', 43000),
(21, 'Hari Prasad', 'hari@gmail.com', 51000),
(22, 'Nisha Kapoor', 'nisha@gmail.com', 34500),
(23, 'Tarun Gill', 'tarun@gmail.com', 39500),
(24, 'Aarthi R', 'aarthi@gmail.com', 48000),
(25, 'Rohit Das', 'rohit@gmail.com', 36500);

SELECT * FROM Employees;

BEGIN TRANSACTION 
BEGIN TRY
INSERT INTO employees VALUES (26,'Arun','arun@gmail.com',25000)
COMMIT TRANSACTION
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
INSERT INTO ErrorLog (ErrorNumber ,ErrorMessage ) 
values 
(ERROR_NUMBER() , ERROR_MESSAGE())
PRINT 'TRANSACTION FAILED'
PRINT ERROR_MESSAGE()
PRINT 'ERROR LINE : ' + cast(ERROR_LINE() as varchar) 
PRINT 'ERROR SEVERITY : ' + cast(ERROR_SEVERITY() as varchar) 
PRINT 'ERROR STATE : ' + cast(ERROR_STATE() as varchar)
END CATCH

select * from ErrorLog