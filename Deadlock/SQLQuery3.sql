
SET DEADLOCK_PRIORITY 4 ; 
BEGIN TRANSACTION 

BEGIN TRY

	UPDATE Person.person set FirstName = 'Session2' where BusinessEntityID = 1 
	WAITFOR DELAY '00:00:05' 
	
	INSERT INTO Person.BusinessEntity (ModifiedDate) values (GETDATE()) 

	
	
	COMMIT TRANSACTION
END TRY

BEGIN CATCH
END CATCH
