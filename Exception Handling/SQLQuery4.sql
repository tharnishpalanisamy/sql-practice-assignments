CREATE TABLE Payroll
(
    EmpID INT identity(1,1),
    BasicSalary MONEY,
    Bonus MONEY,
    Tax MONEY
)


create table payrollErrorLog (
errorId int identity(1,1) , 
errorMessage varchar(300) , 
errorLine varchar(10) , 
errorDate datetime default getdate() 
)


BEGIN TRANSACTION 

BEGIN TRY 
	declare @salary decimal(10,2) = 20000
	declare @bonus decimal(10,2) = 4000 
	declare @tax decimal(10,2)

	BEGIN TRY
		IF @salary < 0 
		BEGIN
			THROW 51000,'Salary cannot be negative' , 1 
		END
	END TRY
	BEGIN CATCH
		INSERT INTO payrollErrorLog (errorMessage , errorLine ) values (ERROR_MESSAGE() , ERROR_LINE()) 
		PRINT ERROR_MESSAGE()
		;THROW 
	END CATCH

	BEGIN TRY
		IF @salary < @bonus 
		BEGIN
			THROW 51000,'Bonus cannot Exceed Salary' , 1 
		END
	END TRY
	BEGIN CATCH
		INSERT INTO payrollErrorLog (errorMessage , errorLine ) values (ERROR_MESSAGE() , ERROR_LINE()) 
		PRINT ERROR_MESSAGE()
		;THROW
	END CATCH
	
	BEGIN TRY
		IF @salary > 20000 
		BEGIN 
			set @tax = 2000 
		END 
		ELSE 
		BEGIN 
			set @tax = 0 
		END
	END TRY
	BEGIN CATCH

		INSERT INTO payrollErrorLog (errorMessage , errorLine ) values (ERROR_MESSAGE() , ERROR_LINE()) 
		PRINT ERROR_MESSAGE()
		;THROW
	END CATCH

	INSERT INTO Payroll (BasicSalary , Bonus , Tax) values (@salary , @bonus , @tax)
	COMMIT TRANSACTION

END TRY 
BEGIN CATCH
ROLLBACK TRANSACTION
INSERT INTO payrollErrorLog (errorMessage , errorLine ) values (ERROR_MESSAGE() , ERROR_LINE()) 
PRINT 'TRANSACTION FAILED'
PRINT ERROR_MESSAGE()
PRINT 'ERROR LINE : ' + cast(ERROR_LINE() as varchar) 
PRINT 'ERROR SEVERITY : ' + cast(ERROR_SEVERITY() as varchar) 
PRINT 'ERROR STATE : ' + cast(ERROR_STATE() as varchar)
END CATCH

select * from Payroll
select * from payrollErrorLog