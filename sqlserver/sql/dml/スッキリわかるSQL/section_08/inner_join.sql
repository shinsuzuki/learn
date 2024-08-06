use AdventureWorks2022
-- 内部結合

-- inner join
select
  sp.BusinessEntityID,
  st.Name as TerritoryName,
  sp.SalesYTD,
  sp.Bonus
from
  Sales.SalesPerson as sp
  inner join Sales.SalesTerritory as st on sp.TerritoryID = st.TerritoryID
