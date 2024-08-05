use AdventureWorks2022
-- 相関複問い合わせ

-- 表
select
  distinct a.SalesOrderID,
  (select sum(b.UnitPrice) from Sales.SalesOrderDetail as b
    where b.SalesOrderID = a.SalesOrderID) as totalUtniPrice
from
  Sales.SalesOrderDetail as a
order by
  a.SalesOrderID


