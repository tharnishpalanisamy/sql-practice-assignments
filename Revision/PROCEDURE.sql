--Phase 11 – Stored Procedures

-- Clean up previous tables if they exist
DROP TABLE IF EXISTS AccountTransactions;
DROP TABLE IF EXISTS Accounts;
GO

-- Create Accounts Table
CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY,
    AccountHolder VARCHAR(100) NOT NULL,
    Balance DECIMAL(18,2) NOT NULL DEFAULT 0.00,
    Status VARCHAR(20) DEFAULT 'Active'
);

-- Create Transactions Table
CREATE TABLE AccountTransactions (
    TransactionID INT IDENTITY(1,1) PRIMARY KEY,
    AccountID INT,
    Amount DECIMAL(18,2) NOT NULL,
    TransactionType VARCHAR(10) NOT NULL, -- 'Deposit' or 'Withdrawal'
    TransactionDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);
GO

-- Insert Sample Data
INSERT INTO Accounts (AccountID, AccountHolder, Balance, Status) VALUES 
(1, 'Alice Smith', 5000.00, 'Active'),
(2, 'Bob Jones', 250.00, 'Active'),
(3, 'Charlie Brown', 10.00, 'Frozen');
GO

--Q66

--Procedure without parameters.

CREATE PROCEDURE SAMPLE 
AS
BEGIN 
PRINT 'SAMPLE' 
END 

EXEC SAMPLE 


--Q67

--Procedure with input parameter.

CREATE PROCEDURE SAMPLE2 
@ID INT 
AS
BEGIN 
SELECT * FROM Accounts WHERE AccountID = @ID 
END 

EXEC SAMPLE2 @ID = 1  

--Q68

--Procedure with output parameter.

CREATE PROCEDURE SAMPLE3 
@INTEREST FLOAT OUTPUT ,
@ID INT 
AS 
BEGIN
SELECT @INTEREST = Balance * 0.05 FROM Accounts WHERE AccountID = @ID ; 
END 

DECLARE @INTEREST FLOAT   
EXEC SAMPLE3 @INTEREST = @INTEREST OUTPUT , @ID = 3 ; 

SELECT @INTEREST AS INTEREST


--Q69

--Procedure returning result set.

ALTER PROCEDURE SAMPLE4 
AS
BEGIN 
	SELECT * 
	FROM Accounts A 

END 

EXEC SAMPLE4 


--Q70

--Procedure using transaction.

--Q71

--Procedure using TRY-CATCH.

ALTER PROCEDURE SAMPLE5 
@ID INT , 
@NAME VARCHAR(3) , 
@BALANCE DECIMAL 
AS
BEGIN 
	BEGIN TRY 
	BEGIN TRANSACTION
	
	INSERT INTO Accounts (AccountID, AccountHolder, Balance)  VALUES (@ID , @NAME , @BALANCE) 

	COMMIT TRANSACTION 
	END TRY 

	BEGIN CATCH 
		ROLLBACK TRANSACTION 
		PRINT ERROR_MESSAGE() 
		PRINT('ACCOUNT ALREADY EXISTS')
	END CATCH  
END 

EXEC SAMPLE5 @ID = 6 , @NAME = 'MIDHUN' , @BALANCE = 50000.00 
SELECT * FROM Accounts

