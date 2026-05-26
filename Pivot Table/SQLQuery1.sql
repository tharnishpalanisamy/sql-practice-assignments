select * from (
select productId, Name as productName , DATENAME(MONTH,SellStartDate) as monthName 
from Production.Product 
where YEAR(SellStartDate) = 2008 
and 
Name in ('Blade' , 'Chain','Adjustable Race','Bearing Ball','BB Ball Bearing') 
)as Source 

Pivot (
count(productId) 
for monthName in (
[January],
[February],
[March],
[April],
[May],
[June],
[July],
[August],
[September],
[October],
[November],
[December]

)
) as result

select * from Production.Product