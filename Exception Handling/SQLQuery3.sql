CREATE TABLE Products
(
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    StockQty INT,
    Price MONEY
)


CREATE TABLE Orders
(
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    OrderDate DATETIME DEFAULT GETDATE()
)

CREATE TABLE OrderDetails
(
    DetailID INT IDENTITY,
    OrderID INT,
    ProductID INT,
    Qty INT,
    Amount MONEY
)

CREATE TABLE OrderErrorLog
(
    ErrorID INT IDENTITY,
    ErrorMessage VARCHAR(500),
    ErrorLine INT,
    ErrorDate DATETIME DEFAULT GETDATE()
)

INSERT INTO Products (ProductID, ProductName, StockQty, Price)
VALUES
(1, 'Laptop', 15, 55000),
(2, 'Mouse', 120, 650),
(3, 'Keyboard', 75, 1200),
(4, 'Monitor', 25, 14500),
(5, 'Printer', 10, 8500),
(6, 'USB Drive', 200, 750),
(7, 'External HDD', 30, 5200),
(8, 'Webcam', 40, 2500),
(9, 'Router', 18, 3200),
(10, 'Headphones', 60, 1800),
(11, 'Smartphone', 22, 28000),
(12, 'Tablet', 14, 22000),
(13, 'Speakers', 35, 3400),
(14, 'Microphone', 28, 4100),
(15, 'Power Bank', 50, 1500),
(16, 'Charger', 90, 900),
(17, 'Graphics Card', 8, 45000),
(18, 'SSD 1TB', 26, 7800),
(19, 'RAM 16GB', 32, 4600),
(20, 'Gaming Chair', 12, 12500);

SELECT * FROM Products;

BEGIN TRANSACTION 

BEGIN TRY
declare @qty int 
set @qty = 15
declare @id int = 1 
declare @availQty int


select @availQty = StockQty from Products where ProductID = @id 

IF @availQty < @qty 
BEGIN 
	THROW 51000,'Quantity Insufficicent' , 1 
END


INSERT INTO orders values
(1,'Tharnish',GETDATE()) 
INSERT INTO OrderDetails (OrderID , ProductID , Qty,Amount) 
values 
(1,@id,@qty,165000) 

update Products set StockQty = StockQty - @qty where ProductID = @id 
commit Transaction 

END TRY 
BEGIN CATCH
ROLLBACK transaction 
insert into OrderErrorLog (ErrorMessage , ErrorLine) values 
(ERROR_MESSAGE() , ERROR_LINE())

PRINT 'TRANSACTION FAILED'
PRINT ERROR_MESSAGE()
PRINT 'ERROR LINE : ' + cast(ERROR_LINE() as varchar) 
PRINT 'ERROR SEVERITY : ' + cast(ERROR_SEVERITY() as varchar) 
PRINT 'ERROR STATE : ' + cast(ERROR_STATE() as varchar)
END CATCH

select * from Products 
select * from orders 
select * from OrderDetails 
select * from OrderErrorLog