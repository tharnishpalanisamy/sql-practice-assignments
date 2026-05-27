CREATE PROCEDURE Proc_Deadlock_2
as
begin

    SET DEADLOCK_PRIORITY LOW

    BEGIN TRY

        BEGIN TRANSACTION

        UPDATE HumanResources.Employee
        SET SickLeaveHours = SickLeaveHours + 1
        WHERE BusinessEntityID = 1

        WAITFOR DELAY '00:00:05'

        UPDATE Person.Person
        SET FirstName = 'Proc2'
        WHERE BusinessEntityID = 1

        COMMIT TRANSACTION

        PRINT 'Procedure 2 Completed'

    END TRY

    BEGIN CATCH

        ROLLBACK TRANSACTION

        if ERROR_NUMBER() = 1205
        BEGIN
            PRINT 'Deadlock Victim'
        END

        else
        BEGIN
            PRINT ERROR_MESSAGE()
        END

    END CATCH

END

DBCC TRACEON(1222, -1)   -- this is used to enable deadlocks monitering 