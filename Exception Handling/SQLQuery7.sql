--- primiry key 
BEGIN TRANSACTION 
	
	BEGIN TRY 
		insert into Person.Person (BusinessEntityID	, PersonType , NameStyle , FirstName , LastName , EmailPromotion , ModifiedDate) 
		values (1,1,1,'hi','bye',1,GETDATE()) 
		COMMIT TRANSACTION
	END TRY 

	BEGIN CATCH 
		ROLLBACK TRANSACTION
		PRINT 'TRANSACTION FAILED'
		PRINT ERROR_MESSAGE()
		PRINT 'ERROR LINE : ' + cast(ERROR_LINE() as varchar) 
		PRINT 'ERROR SEVERITY : ' + cast(ERROR_SEVERITY() as varchar) 
		PRINT 'ERROR STATE : ' + cast(ERROR_STATE() as varchar)
	END CATCH


--foreign key 
BEGIN TRANSACTION

BEGIN TRY
    delete from Person.Person
    where BusinessEntityID = 1

    COMMIT TRANSACTION
END TRY

BEGIN CATCH
    ROLLBACK TRANSACTION
    PRINT 'FK Constraint Error'
    PRINT ERROR_MESSAGE()
	PRINT 'ERROR LINE : ' + cast(ERROR_LINE() as varchar) 
	PRINT 'ERROR SEVERITY : ' + cast(ERROR_SEVERITY() as varchar) 
	PRINT 'ERROR STATE : ' + cast(ERROR_STATE() as varchar)
END CATCH



---divide by zero 
BEGIN TRANSACTION 

BEGIN TRY
	select 5 / 0 
	commit transaction
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	select 'ERROR'
	select ERROR_MESSAGE() 
	select 'ERROR LINE : ' + cast(ERROR_LINE() as varchar) 
	select 'ERROR SEVERITY : ' + cast(ERROR_SEVERITY() as varchar) 
	select 'ERROR STATE : ' + cast(ERROR_STATE() as varchar)
END CATCH





--salary greater than 10000
create Table employee (
empId int identity(1,1) primary key , 
empName varchar(30) , 
salary money check (salary > 10000) 
)

BEGIN TRANSACTION 

BEGIN TRY
	Insert into employee (empName , salary) values ('Tharnish' , 6800)
	COMMIT TRANSACTION 
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION 
	PRINT 'Salary should be greater than 10000'
	PRINT ERROR_MESSAGE()
	PRINT 'ERROR LINE : ' + cast(ERROR_LINE() as varchar) 
	PRINT 'ERROR SEVERITY : ' + cast(ERROR_SEVERITY() as varchar) 
	PRINT 'ERROR STATE : ' + cast(ERROR_STATE() as varchar)
END CATCH

---unique 
create table records (
recordNo int unique , 
name varchar(20) not null , 
)



BEGIN TRANSACTION 

BEGIN TRY
	insert into records values (1,'science')
	Commit transaction
END TRY

BEGIN CATCH 
	ROLLBACK TRANSACTION 
	PRINT 'Violation of unique key '
	PRINT ERROR_MESSAGE() 
	PRINT 'ERROR LINE : ' + cast(ERROR_LINE() as varchar) 
	PRINT 'ERROR SEVERITY : ' + cast(ERROR_SEVERITY() as varchar) 
	PRINT 'ERROR STATE : ' + cast(ERROR_STATE() as varchar)
END CATCH

--not null 
BEGIN TRANSACTION 

BEGIN TRY
	insert into records (recordNo) values (2)
	commit TRANSACTION 
END TRY 

BEGIN CATCH
	ROLLBACK TRANSACTION
	PRINT 'Not null contrainst' 
	PRINT ERROR_MESSAGE()
	PRINT 'ERROR LINE : ' + cast(ERROR_LINE() as varchar) 
	PRINT 'ERROR SEVERITY : ' + cast(ERROR_SEVERITY() as varchar) 
	PRINT 'ERROR STATE : ' + cast(ERROR_STATE() as varchar)
END CATCH