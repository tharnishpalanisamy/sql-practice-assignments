--Phase 10 – Indexes


-- Clean up previous table if it exists
DROP TABLE IF EXISTS Products;
GO

-- Create the practice table
CREATE TABLE Products (
    ProductID INT NOT NULL, -- We leave PRIMARY KEY off initially to practice Clustered Index
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    StockQuantity INT,
    IsActive BIT DEFAULT 1
);
GO

-- Insert Sample Data
INSERT INTO Products (ProductID, ProductName, Category, Price, StockQuantity, IsActive) VALUES 
(105, 'Laptop Pro', 'Electronics', 1200.00, 15, 1),
(101, 'Wireless Mouse', 'Electronics', 25.00, 120, 1),
(104, 'Office Chair', 'Furniture', 150.00, 8, 1),
(102, 'Desk Lamp', 'Furniture', 45.00, 0, 0),
(103, 'Bluetooth Speaker', 'Electronics', 80.00, 45, 1);
GO

--Q60

--Create clustered index.
CREATE CLUSTERED INDEX CIPK 
ON Products(ProductID) 
--Q61

--Create non-clustered index.

CREATE NONCLUSTERED INDEX NCI 
ON Products(ProductName)

--Q62

--Create filtered index.

CREATE NONCLUSTERED INDEX FILTERINDEX1
ON Products(price , StockQuantity) 
WHERE PRICE > 20.00  AND StockQuantity = 0 ; 

SELECT * FROM Products WHERE PRICE > 20 AND StockQuantity = 0 ; 

--Q63

--How to check index usage?
SELECT 
    OBJECT_NAME(s.object_id) AS TableName,
    i.name AS IndexName,
    s.user_seeks AS IndexSeeks,    -- Direct jumps to data (Excellent Performance)
    s.user_scans AS IndexScans,    -- Scanned the whole index (Good, but room to improve)
    s.user_lookups AS Lookups,     -- Jumped from non-clustered to clustered index
    s.user_updates AS TotalWrites  -- How many times updates slowed down for this index
FROM sys.dm_db_index_usage_stats s
INNER JOIN sys.indexes i ON i.object_id = s.object_id AND i.index_id = s.index_id
WHERE s.object_id = OBJECT_ID('Products');
GO

--Q64

--When does index hurt performance? 
--INDEX IS BASICALLY USED TO OPTIMIZE READ / RETRIEVAL OPERATIONS SO FREQUENT 
--INSERT UPDATE OR DELETE HURTS THE PERFORMANCE OF INDEX 
--Q65

--Clustered vs Non-Clustered.
--CI DETERMINES THE THE PHYSICAL SORTING ORDER OF THE COLUMN - ONLY ONE FOR A TABLE , 

--NCI IT HOLDS SORTED INDEX KEYS ALONG WITH THE POINTER TO WHERE THR REAL ROW IS . 
--YOU CAN HAVE 999 NCI 




--These came from your SP/Trigger/Index assignment.