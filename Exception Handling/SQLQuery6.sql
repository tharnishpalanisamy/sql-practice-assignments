CREATE TABLE ProductMaster
(
    ProductID INT identity(1,1) primary key,
    ProductName VARCHAR(100) unique,
    Price MONEY
)

BEGIN TRANSACTION 

BEGIN TRY
		declare @name varchar(20) = 'Pen' 
		declare @price money = 100

		IF @price > 100000 
			BEGIN 
				THROW 51000,'Price cannot exceed 100000' , 1 
			END 
		ELSE IF @price <= 0 
			BEGIN 
				THROW 51000 , 'Price cannot be Zero or negative ' , 1
			END 

		BEGIN TRY 
			INSERT INTO ProductMaster (ProductName , Price) values (@name , @price ) 
			COMMIT TRANSACTION 
		END TRY 

		BEGIN CATCH 
			THROW 51000,'Cannot insert duplicate items' , 1
		END CATCH
END TRY 

BEGIN CATCH
	ROLLBACK TRANSACTION 
	PRINT 'TRANSACTION FAILED'
	PRINT ERROR_MESSAGE()
	PRINT 'ERROR LINE : ' + cast(ERROR_LINE() as varchar) 
	PRINT 'ERROR SEVERITY : ' + cast(ERROR_SEVERITY() as varchar) 
	PRINT 'ERROR STATE : ' + cast(ERROR_STATE() as varchar)
END CATCH

select * from ProductMaster