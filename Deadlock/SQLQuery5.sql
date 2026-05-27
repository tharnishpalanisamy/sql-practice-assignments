ALTER PROCEDURE Proc_Deadlock_2
as
begin

    SET DEADLOCK_PRIORITY 10

    BEGIN TRY

        BEGIN TRANSACTION

        UPDATE HumanResources.Employee
        SET SickLeaveHours = 10
        WHERE BusinessEntityID = 1

        WAITFOR DELAY '00:00:05'

        UPDATE Person.Person
        SET FirstName = 'Proc2'
        WHERE BusinessEntityID = 1

        COMMIT TRANSACTION

        PRINT 'Procedure 2 Completed'

    END TRY

    BEGIN CATCH

        IF @@TRANCOUNT > 0
		BEGIN
			ROLLBACK TRANSACTION
		END

        if ERROR_NUMBER() = 1205
        BEGIN
            PRINT 'this trnasaction is a Deadlock Victim'
        END

        else
        BEGIN
            PRINT ERROR_MESSAGE()
        END

    END CATCH

END

exec Proc_Deadlock_2

DBCC TRACEON(1222, -1)   -- this is used to enable deadlocks monitering 