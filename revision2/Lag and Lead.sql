--Phase 8 – LAG / LEAD

-- ============================================
-- DROP TABLE
-- ============================================

DROP TABLE IF EXISTS Orders;

-- ============================================
-- CREATE TABLE
-- ============================================

CREATE TABLE Orders
(
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    OrderDate DATE,
    OrderAmount DECIMAL(10,2),
    SalesPerson VARCHAR(50)
);

-- ============================================
-- INSERT DATA
-- ============================================

INSERT INTO Orders
(OrderID, CustomerName, OrderDate, OrderAmount, SalesPerson)
VALUES
(101,'Rahul','2025-01-01',1200,'Alice'),
(102,'Priya','2025-01-03',1800,'Bob'),
(103,'Karan','2025-01-06',1500,'Alice'),
(104,'Sneha','2025-01-10',2200,'Charlie'),
(105,'Vijay','2025-01-15',2700,'Bob'),
(106,'Anu','2025-01-18',2100,'Alice'),
(107,'Rohit','2025-01-22',3200,'Charlie'),
(108,'Meena','2025-01-27',2800,'Bob'),
(109,'Arjun','2025-02-01',3500,'Alice'),
(110,'Divya','2025-02-08',3900,'Charlie');


--Q51

--Compare current sale with previous sale.

select * , lag(OrderAmount) over(order by orderId) - OrderAmount as difference
from Orders 

--Q52

--Find salary growth compared with previous employee.
select * ,salary - lag(Salary) over(order by empId ) as salaryGrowth
from Employees

--Q53

--Find days gap between orders.
select * , DATEDIFF(DAY , OrderDate , lead(orderDate) over(order by orderId)) as dayDifference
from Orders

--Q54

--Display next order amount.
select * , lead(orderAmount) over(order by orderId) as nextOrder
from Orders

--These are directly from your window-function assignment.

--Find whether the current order is higher or lower than the previous order.
select * , 
case 
WHEN lag(orderAmount) over(order by orderId ) is NULL then 'First Order' 
WHEN lag(orderAmount) over(order by orderId ) > OrderAmount THEN 'Higher' ELSE 'lower' end as status
from Orders


--Show the previous and next order amount together.
select * , lag(OrderAmount) over(order by orderId) as previousOrder , lead(OrderAmount) over(order by orderId) as nextOrder
from Orders