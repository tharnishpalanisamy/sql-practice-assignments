
SET DEADLOCK_PRIORITY 4 ; 


BEGIN TRY
	BEGIN TRANSACTION 

	UPDATE Person.BusinessEntity
    SET ModifiedDate = GETDATE()
    WHERE BusinessEntityID = 1 

	WAITFOR DELAY '00:00:05'

	UPDATE Person.person set FirstName = 'Session2' where BusinessEntityID = 1 

	COMMIT TRANSACTION
END TRY

BEGIN CATCH
	PRINT ERROR_MESSAGE()
END CATCH
