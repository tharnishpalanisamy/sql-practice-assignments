-- person , employee , business entity 

SET DEADLOCK_PRIORITY 10 ; 
BEGIN TRANSACTION  

--BEGIN TRY 
	INSERT INTO HumanResources.Employee (BusinessEntityID , NationalIDNumber , LoginID ,
	JobTitle , BirthDate , MaritalStatus , Gender , HireDate , SalariedFlag , VacationHours , SickLeaveHours , CurrentFlag , ModifiedDate )
	values 
	(304,123123123,12341234,'deadlock','2005-07-25' , 'M' , 'M', '2026-03-16' , 1 , 10 , 10 , 1 , GETDATE())

	WAITFOR DELAY '00:00:05' 


	UPDATE Person.person set FirstName = 'sastha' where BusinessEntityID = 3;

	COMMIT TRANSACTION
END TRY 
	
BEGIN CATCH
	ROLLBACK TRANSACTION
    PRINT ERROR_MESSAGE()
END CATCH