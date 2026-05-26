CREATE TABLE Candidate
(
    CandidateID INT identity(1,1),
    CandidateName VARCHAR(100),
    Age INT
)

BEGIN TRANSACTION 

BEGIN TRY
declare @name varchar(20) = 'ajay'
	declare @age int = 12 

	IF @age < 18 
	BEGIN 
		THROW 51000 , 'Invalid age , age should be above 18' , 1 
	END 

	INSERT Into Candidate (CandidateName , Age) values (@name , @age) 
	commit Transaction 

END TRY 

BEGIN CATCH
	ROLLBACK TRANSACTION 
	PRINT 'TRANSACTION FAILED'
	PRINT ERROR_MESSAGE()
	PRINT 'ERROR LINE : ' + cast(ERROR_LINE() as varchar) 
	PRINT 'ERROR SEVERITY : ' + cast(ERROR_SEVERITY() as varchar) 
	PRINT 'ERROR STATE : ' + cast(ERROR_STATE() as varchar)

END CATCH