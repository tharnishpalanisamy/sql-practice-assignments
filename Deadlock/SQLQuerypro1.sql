CREATE TABLE TableA
(
    ID INT PRIMARY KEY,
    Name VARCHAR(50)
)

CREATE TABLE TableB
(
    ID INT PRIMARY KEY,
    Amount INT
)

INSERT INTO TableA VALUES (1, 'Initial')

INSERT INTO TableB VALUES (1, 100)

ALTER PROCEDURE Proc1
AS
BEGIN

    SET DEADLOCK_PRIORITY 3

    BEGIN TRY

        BEGIN TRANSACTION

        UPDATE TableA
        SET Name = 'Proc1'
        WHERE ID = 1

        WAITFOR DELAY '00:00:05'

        UPDATE TableB
        SET Amount = Amount + 10
        WHERE ID = 1

        COMMIT TRANSACTION

        PRINT 'Procedure 1 Completed'

    END TRY

    BEGIN CATCH

        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION
        END

        PRINT 'Procedure 1 Failed'
        PRINT ERROR_MESSAGE()

    END CATCH

END


EXEC Proc1