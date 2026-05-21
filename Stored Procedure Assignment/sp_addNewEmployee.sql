
CREATE PROCEDURE addNewEmployee
	@personType nchar(2) , 
	@nameStyle bit , 
	@firstName nvarchar(50) , 
	@lastName nvarchar(50) , 
	@emailPromotion int ,
    @nationalId NVARCHAR(15),
    @loginId NVARCHAR(256),
    @jobTitle NVARCHAR(50),
    @birthDate DATE,
    @maritalStatus NCHAR(1),
    @gender NCHAR(1),
    @hireDate DATE,
    @salariedFlag BIT,
    @vacationHours SMALLINT,
    @sickLeaveHours SMALLINT,
    @modifiedDate DATETIME , 
	@deptId SMALLINT , 
	@shiftId TINYINT , 
	@startDate date ,
	@RateChangeDate datetime,
	@rate money,
	@PayFrequency tinyint

AS
BEGIN 
SET NOCOUNT ON;
DECLARE @empId int 

IF @rate <= 0 
BEGIN
	PRINT 'Please Enter A valid Rate'
	RETURN
END


if @maritalStatus NOT IN ('S','M') 
BEGIN 
	PRINT 'Enter a valid Marital Status' 
	RETURN 
END 

IF @birthDate >= GETDATE()
BEGIN
    PRINT 'Birth date cannot be future date'
    RETURN
END

IF DATEDIFF(YEAR, @birthDate, GETDATE()) < 18
BEGIN
    PRINT 'Employee age must be greater than 18 , You are trying To employee a child which will lead to legal issues'
    RETURN
END

IF @gender NOT IN ('M','F') 
BEGIN 
	PRINT('Please enter you Gender Correctly') 
	RETURN
END


IF NOT EXISTS (SELECT 1 from HumanResources.Department where DepartmentID = @deptId) 
BEGIN 
	PRINT 'The Department doesnt exists enter a valid Department ' 
	RETURN 
END


IF NOT EXISTS (SELECT 1 from HumanResources.Shift where shift.ShiftID = @shiftId) 
BEGIN 
	PRINT 'The Shift doesnt exist enter a valid shift' 
	RETURN
END

IF @vacationHours < 0
BEGIN
    PRINT 'Vacation hours cannot be negative , Employees must be given Vacation time'
    RETURN
END

IF @sickLeaveHours < 0
BEGIN
    PRINT 'Sick Leave hours hours cannot be negative , Employees must be given sick leave time'
    RETURN
END


BEGIN TRY

BEGIN TRANSACTION 
	INSERT INTO person.BusinessEntity ( ModifiedDate) 
	values(
	@modifiedDate)

	set @empId = SCOPE_IDENTITY() 



	INSERT INTO person.Person 
	(BusinessEntityID , PersonType , NameStyle , FirstName , LastName , EmailPromotion , ModifiedDate) 
	values(
	@empId , 
	@personType , 
	@nameStyle , 
	@firstName , 
	@lastName , 
	@emailPromotion , 
	@modifiedDate
	)

    INSERT INTO HumanResources.Employee
    (
        BusinessEntityID,
        NationalIDNumber,
        LoginID,
        JobTitle,
        BirthDate,
        MaritalStatus,
        Gender,
        HireDate,
        SalariedFlag,
        VacationHours,
        SickLeaveHours,
		CurrentFlag,
        ModifiedDate
    )
    VALUES
    (
        @empId,
        @nationalId,
        @loginId,
        @jobTitle,
        @birthDate,
        @maritalStatus,
        @gender,
        @hireDate,
        @salariedFlag,
        @vacationHours,
        @sickLeaveHours,
		@salariedFlag,
        @modifiedDate
    )
	INSERT INTO HumanResources.EmployeeDepartmentHistory 
	(BusinessEntityID , DepartmentID , ShiftID , StartDate , ModifiedDate) 
	values(
	@empId,
	@Deptid,
	@ShiftId,
	@StartDate,
	@ModifiedDate
	)

INSERT INTO HumanResources.EmployeePayHistory
(BusinessEntityID,RateChangeDate,Rate,PayFrequency,ModifiedDate)
VALUES 
(
	@empId,
	@RateChangeDate,
	@rate,
	@PayFrequency,
	@ModifiedDate

)
COMMIT TRANSACTION
PRINT 'Employee Added Successfully';
SELECT 'Employee Added Successfully' AS Message , @empId as NewEmployeeID; 

SELECT e.BusinessEntityID as EmployeeId , p.FirstName +' ' + p.LastName as EmployeeName,ed.DepartmentID , 
d.Name as department , s.Name as Shift , e.JobTitle , e.HireDate , ep.Rate
from HumanResources.Employee e 
join Person.Person p on e.BusinessEntityID = p.BusinessEntityID 
join HumanResources.EmployeeDepartmentHistory ed on e.BusinessEntityID = ed.BusinessEntityID 
join HumanResources.Department d on ed.DepartmentID = d.DepartmentID 
join HumanResources.Shift s on ed.ShiftID = s.ShiftID 
join HumanResources.EmployeePayHistory as ep on e.BusinessEntityID = ep.BusinessEntityID 
where e.BusinessEntityID = @empId 


END TRY

BEGIN CATCH 
	ROLLBACK TRANSACTION
	PRINT 'ERROR: THE stored Procedure Failed and Transacton is rolled back'
	PRINT ERROR_MESSAGE()
    PRINT CAST(ERROR_LINE() AS VARCHAR)
END CATCH
END
GO


drop procedure addNewEmployee


EXEC addNewEmployee 
	'IN' , 
	0 , 
	'Midhun',
	'V',
	2 , 
	'64102410',
	'GG006' , 
	'Software Trainee' ,
	'2005-12-12' , 
	'S',
	'M',
	'2026-03-16' , 
	1,
	5,
	10,
	'2026-05-16' , 
	5 , 
	2 ,
	'2026-05-16' , 
	'2026-05-16' , 
	150,
	2



    

