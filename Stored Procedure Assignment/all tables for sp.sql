select * from HumanResources.Employee 
select * from HumanResources.Department 
select * from HumanResources.Shift 
select * from HumanResources.EmployeePayHistory 
select * from HumanResources.EmployeeDepartmentHistory 
select * from Person.Person
EXEC sp_helpconstraint 'HumanResources.EmployeePayHistory'


CREATE PROCEDURE addNewEmployee
    @empId INT,
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
	@currentFlag BIT,
    @modifiedDate DATETIME , 
	@deptId SMALLINT , 
	@shiftId TINYINT , 
	@startDate date ,
	@RateChangeDate datetime,
	@rate money,
	@PayFrequency tinyint