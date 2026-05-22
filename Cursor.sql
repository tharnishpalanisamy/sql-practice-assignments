declare @name varchar(20) 
declare @salary decimal(10,2) 

declare empCursor CURSOR FOR 
select EmployeeName , Salary
from Employees

open empCursor 

Fetch Next from empCursor into @name , @salary 

while @@FETCH_STATUS = 0

BEGIN 
	PRINT 'Employeee : ' + @name 
	PRINT 'Salary : '+ cast(@salary as varchar) 
	FETCH NEXT FROM empCursor into @name , @salary
END

close empCursor 

deallocate empCursor