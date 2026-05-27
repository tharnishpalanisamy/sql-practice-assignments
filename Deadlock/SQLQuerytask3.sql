declare @retry int = 3 
declare @success int = 0 
declare @attempt int = 1 
declare @errorNo int 
declare @errorMes varchar(400) 


WHILE (@attempt <= @retry and @success = 0 ) 
BEGIN 
	BEGIN TRY
		BEGIN TRANSACTION 
		
		update person.Person set FirstName = FirstName + ' task3' where BusinessEntityID = 1 

		waitfor delay '00:00:05' 

		UPDATE HumanResources.Employee
        SET SickLeaveHours = SickLeaveHours + 1
        WHERE BusinessEntityID = 1

		COMMIT TRANSACTION 
		set @success = 1 
		PRINT 'Transaction successful' 
	END TRY 

	BEGIN CATCH
		
		if @@TRANCOUNT > 0 
			BEGIN 
				rollback transaction
			END

		set @errorNo = ERROR_NUMBER()
		set @errorMes = ERROR_MESSAGE()

		PRINT 'ERROR No: '+cast(@errorNo as varchar) 
		PRINT 'Error message : ' + @errorMes  

		If @errorNo = 1205 
			BEGIN 
				IF @attempt > 4 
					BEGIN 
						PRINT 'Maxmium attempts exceeded , Transaction is aborted' 
					END
				PRINT 'Deadlock is occured , transaction is exceuting again' 
				set @attempt = @attempt + 1 
			END

	END CATCH
END 