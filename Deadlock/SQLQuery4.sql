CREATE PROCEDURE proc1 
as
begin 

	set deadlock_priority 3 
	
	BEGIN TRY

        BEGIN TRANSACTION

        UPDATE Person.Person
        SET FirstName = 'Proc1'
        WHERE BusinessEntityID = 1

        WAITFOR DELAY '00:00:05'

        UPDATE HumanResources.Employee
        SET VacationHours = VacationHours + 1
        WHERE BusinessEntityID = 1

        COMMIT TRANSACTION

        PRINT 'Procedure 1 Completed'

    END TRY

	BEGIN CATCH 
		ROLLBACK TRANSACTION 
		PRINT 'Procedure 1 failed' 
		PRINT ERROR_MESSAGE()
	END CATCH
END