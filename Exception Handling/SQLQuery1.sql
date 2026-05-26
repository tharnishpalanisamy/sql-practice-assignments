CREATE TABLE Accounts
(
    AccountNo INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    Balance MONEY
)

INSERT INTO Accounts (AccountNo, CustomerName, Balance)
VALUES
(1001, 'Arun Kumar', 25000),
(1002, 'Priya Sharma', 42000),
(1003, 'Kavin Raj', 18500),
(1004, 'Divya Lakshmi', 53000),
(1005, 'Rahul Verma', 12000),
(1006, 'Sneha Reddy', 67000),
(1007, 'Vikram Singh', 31000),
(1008, 'Meena Nair', 28000),
(1009, 'Ajay Patel', 15000),
(1010, 'Harini Devi', 72000),
(1011, 'Sanjay Kumar', 36000),
(1012, 'Deepika Rao', 41000),
(1013, 'Naveen Babu', 9500),
(1014, 'Lavanya S', 88000),
(1015, 'Mohit Jain', 27000),
(1016, 'Ritika Mehta', 33000),
(1017, 'Anand Krish', 46000),
(1018, 'Keerthana P', 51000),
(1019, 'Suresh Mani', 14500),
(1020, 'Pooja Yadav', 39000),
(1021, 'Hari Prasad', 61000),
(1022, 'Nisha Kapoor', 22500),
(1023, 'Tarun Gill', 34000),
(1024, 'Aarthi R', 57000),
(1025, 'Rohit Das', 29500);

SELECT * FROM Accounts;

BEGIN TRANSACTION 
declare @balance decimal(10,2) 
BEGIN TRY
select @balance= Balance from accounts where AccountNo = 1002

if @balance < 5000 
BEGIN 
	THROW 51000,'Balance is insuficient',1
END 

update accounts set Balance = Balance - 5000 where AccountNo = 1002 ; 
update accounts set Balance = Balance + 5000 where AccountNo = 1003 ;
commit transaction 
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
PRINT 'Error Occurred ' 
PRINT'ERROR number '+  cast(ERROR_NUMBER() as varchar)  
PRINT 'Error line ' +  cast(ERROR_LINE() as varchar)
PRINT 'Error severity ' + cast(ERROR_SEVERITY() as varchar)
PRINT 'Error State ' + cast(ERROR_STATE() as varchar)
END CATCH

select * from accounts