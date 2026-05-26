select * from Sales.SalesOrderHeader

select * from (
select TerritoryID , YEAR(OrderDate) as yesr , TotalDue from sales.SalesOrderHeader
) as source 

pivot (
sum(totalDue) 
for territoryId in (
[1],
[2] , 
[3],
[4],
[5] , 
[6],
[7],
[8] , 
[9],
[10])
) as pivotTable