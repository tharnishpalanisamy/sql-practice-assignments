--a. Create a table Hobbies (HobbyID(pk), HobbyName(uk)) 

create table hobbies (
hobbyId int primary key , 
hobbyName varchar(30) unique  
)

INSERT INTO hobbies (hobbyId, hobbyName) VALUES
(1, 'Reading'),
(2, 'Gaming'),
(3, 'Cooking'),
(4, 'Photography'),
(5, 'Painting'),
(6, 'Gardening'),
(7, 'Cycling'),
(8, 'Swimming'),
(9, 'Traveling'),
(10, 'Drawing'),
(11, 'Dancing'),
(12, 'Singing'),
(13, 'Writing'),
(14, 'Fishing'),
(15, 'Hiking');

select * from hobbies

--1. Insert records into the table using a stored procedure.

CREATE PROCEDURE insertNewHobby 
@hobbyId int , 
@hobbyName varchar(30)

AS
BEGIN 
INSERT INTO hobbies VALUES
(@hobbyId , @hobbyName) 
END

exec insertNewHobby 16 , 'cricket'
select * from hobbies order by hobbyId

--2. Insert duplicate records into the table and show the working of exception handling using Try/catch blocks.

ALTER PROCEDURE insertNewHobby 
@hobbyId int , 
@hobbyName varchar(30)

AS
BEGIN 
BEGIN TRY
	BEGIN TRANSACTION
	INSERT INTO hobbies VALUES
	(@hobbyId , @hobbyName) 
	COMMIT TRANSACTION
END TRY 
BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION 
	PRINT 'Insert Failed , Duplicate Values cannot be inserted' 
	PRINT ERROR_MESSAGE()
END CATCH
END

exec insertNewHobby 16 , 'cricket'

--3. Store the error details in an errorbackup table.
create table errorBackup (
errorId int identity(1,1) , 
errorMessage varchar(255) 
)

ALTER PROCEDURE insertNewHobby 
@hobbyId int , 
@hobbyName varchar(30)

AS
BEGIN 
BEGIN TRY
	BEGIN TRANSACTION
	INSERT INTO hobbies VALUES
	(@hobbyId , @hobbyName) 
	COMMIT TRANSACTION
END TRY 
BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION 
		insert into errorBackup (errorMessage) Values (ERROR_MESSAGE())
	PRINT 'Insert Failed , Duplicate Values cannot be inserted' 
	PRINT ERROR_MESSAGE()
END CATCH
END

exec insertNewHobby 16 , 'cricket'
select * from errorBackup


--b. Create a procedure to accept 2 numbers, if the numbers are equal then calculate the product else use RAISERROR
--to show the working of exception handling.

CREATE PROCEDURE multiply 
@n1 int , 
@n2 int 
AS
BEGIN 

IF @n1 <> @n2
BEGIN
	PRINT 'Both Numbers should be equal '
	RAISERROR ('Both numbers should be equal', 16, 1)
	RETURN
END

declare @product int 
set @product = @n1 * @n2 
select @product

END

exec multiply 5 , 5

--c. Create a table Friends(id(identity), name (uk)) and insert records into the table using a stored procedure.
--    Note: insert the names which start only with A,D,H,K,P,R,S,T,V,Y ELSE using THROW give the error details.
create Table friends(
id int identity(1,1) , 
name varchar(20) unique
)

ALTER PROCEDURE insertName 
@name varchar(30) 
AS 
BEGIN 

IF @name like '[ADHKPRSTVY]%' 
BEGIN 
	INSERT INTO friends (name) VALUES (@name) 
END 
ELSE 
BEGIN
	print('Name should start with one of A,D,H,K,P,R,S,T,V,Y');
	THROW 50001,
        'Name should start only with A,D,H,K,P,R,S,T,V,Y',
        1
END
END

exec insertName 'Akash'
exec insertName 'balu'
select * from friends 