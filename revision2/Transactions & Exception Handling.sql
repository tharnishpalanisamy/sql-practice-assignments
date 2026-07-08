--Phase 16 – Transactions & Exception Handling

--Very important for office review.
-- Drop table
DROP TABLE IF EXISTS BankAccounts;

-- Create table
CREATE TABLE BankAccounts (
    AccountID INT PRIMARY KEY,
    AccountHolder VARCHAR(50),
    Balance DECIMAL(10,2)
);

-- Insert sample data
INSERT INTO BankAccounts VALUES
(101, 'Arun', 50000),
(102, 'Priya', 30000),
(103, 'Rahul', 15000),
(104, 'Sneha', 80000);

SELECT * FROM BankAccounts;


--Q86

--Money transfer with COMMIT.

--Q87

--Money transfer with ROLLBACK.

declare @from int = 101 
declare @to int = 102 
declare @amount decimal(10,2) = 15000 
declare @balance decimal(10,2)  

begin transaction 

begin try 
	select @balance = Balance from  BankAccounts where AccountID = @from 

	if(@balance >= @amount) 
		begin 
			update BankAccounts set Balance = Balance - @amount where AccountID = @from 

			update BankAccounts set Balance = Balance + @amount where AccountID = @to
			commit transaction 
		end 
	else 
		begin 
			RAISERROR('Insufficient Balance' , 16 , 1 )
		end 
end try 
begin catch
	rollback transaction 
	print ERROR_MESSAGE() 
end catch 



--Q88

-- Drop Tables
DROP TABLE IF EXISTS ErrorLogs;
DROP TABLE IF EXISTS Employees;

-- Employees Table
CREATE TABLE Employees(
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(50),
    Salary DECIMAL(10,2)
);

INSERT INTO Employees VALUES
(101,'Arun',35000),
(102,'Priya',42000),
(103,'Rahul',51000);

-- Error Log Table
CREATE TABLE ErrorLogs(
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    ErrorMessage NVARCHAR(4000),
    ErrorDate DATETIME DEFAULT GETDATE()
);

SELECT * FROM Employees;
SELECT * FROM ErrorLogs;

--TRY-CATCH logging.

begin try 
	insert into Employees values (103 , 'Tharnish' , 1000000) 
end try 

begin catch 
	insert into ErrorLogs (ErrorMessage) values (ERROR_MESSAGE())
end catch 

--Q89

--Custom THROW error.

--declare @empSalary decimal(10,2)  = 6800

--begin try
--	if @empSalary > 10000  
--	begin 
--		insert into Employees values (106 , 'tharnish' , @empSalary)
--	end 

--	else 
--		throw 50001 , 'Company policy restricts paying employees under 10k' , 1  

--end try 

--begin catch 
--	print ERROR_MESSAGE() 
--	insert into ErrorLogs (ErrorMessage) values (ERROR_MESSAGE())
	
--end catch


--Q90

-- Drop Tables
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Inventory;

-- Inventory
CREATE TABLE Inventory(
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Stock INT
);

INSERT INTO Inventory VALUES
(1,'Laptop',10),
(2,'Mouse',40),
(3,'Keyboard',25),
(4,'Monitor',8);

-- Orders
CREATE TABLE Orders(
    OrderID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT
);

SELECT * FROM Inventory;
SELECT * FROM Orders;


--Nested TRY-CATCH.
begin try 
	begin transaction 

	begin try 
		declare @productId int = 2 
		declare @qty int = 4 
		

		if not exists(select 1 from Inventory where ProductID = @productId)
		begin
		;
			throw 50001 , 'Product not exists' , 1 ;
		end 

		if @qty > (select stock from Inventory where ProductID = @productId) 
		begin 
		;
			throw 50001 , 'Insufficient supply' , 1 ;
		end
		
		insert into Orders values (1 , @productId , @qty )
		update Inventory set Stock = stock - @qty where ProductID = @productId 
	end try 

	begin catch 
		PRINT 'Error occured';
		throw ;
	end catch 

	commit transaction

end try 

begin catch 
	PRINT ERROR_MESSAGE() 
	rollback transaction
end catch 

--Q91

--Stock/order processing transaction.

--These directly match your exception-handling tasks.