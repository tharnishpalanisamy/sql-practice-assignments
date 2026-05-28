-- person , employee , business entity 

SET DEADLOCK_PRIORITY 10 ; 

BEGIN TRY 
BEGIN TRANSACTION  

	UPDATE Person.BusinessEntity
    SET ModifiedDate = GETDATE()
    WHERE BusinessEntityID = 1

	WAITFOR DELAY '00:00:05' 


	update HumanResources.Employee set HireDate = GETDATE() where BusinessEntityID = 2

	COMMIT TRANSACTION
END TRY 
	
BEGIN CATCH
	ROLLBACK TRANSACTION
    PRINT ERROR_MESSAGE()
END CATCH