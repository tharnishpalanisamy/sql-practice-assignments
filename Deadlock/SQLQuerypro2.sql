CREATE OR ALTER PROCEDURE Proc2
AS
BEGIN

    SET DEADLOCK_PRIORITY 10

    BEGIN TRY

        BEGIN TRANSACTION

        UPDATE TableB
        SET Amount = Amount + 20
        WHERE ID = 1

        WAITFOR DELAY '00:00:05'

        UPDATE TableA
        SET Name = 'Proc2'
        WHERE ID = 1

        COMMIT TRANSACTION

        PRINT 'Procedure 2 Completed'

    END TRY

    BEGIN CATCH

        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION
        END

        PRINT 'Procedure 2 Failed'
        PRINT ERROR_MESSAGE()

    END CATCH

END


DBCC TRACEON(1222, -1)

EXEC Proc2