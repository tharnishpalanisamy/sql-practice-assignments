--Task – 7
--Show the working of the following concepts for the students table created in the earlier tasks.

--1. Auto-commit and Auto-rollback transactions.
select * from student
BEGIN TRY
	insert into student values (16,'praveen',3,500,500)
END TRY
BEGIN CATCH 
	PRINT('Auto Rollback happened') 
	PRINT ERROR_MESSAGE()
END CATCH

--2. Implicit transactions

SET IMPLICIT_TRANSACTIONS ON
INSERT INTO student
VALUES (21, 'Arun', 4,400,500)
COMMIT TRANSACTION

SET IMPLICIT_TRANSACTIONS OFF


--3. Explicit transactions

--    a. Only Commit - insert statement

BEGIN TRANSACTION

INSERT INTO students
VALUES (101, 'Ram', 450)

COMMIT TRANSACTION

--    b. Only Rollback - update statement

BEGIN TRANSACTION 
update student set securedMarks = 450 where studentId = 20 
Rollback TRANSACTION

--    c. Savepoint - commit update and insert statements, rollback delete statement

BEGIN TRANSACTION 

update student set securedMarks = 496 where studentId = 10 

insert student values (22,'mukesh',2,200,500)

save TRANSACTION savepoint1

delete from student where studentId = 15 

rollback Transaction savepoint1

commit transaction

select * from student