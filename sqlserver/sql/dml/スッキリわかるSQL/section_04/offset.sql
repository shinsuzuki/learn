use AdventureWorks2022

-- OFFSET演算子
-- top3
select
  *
from
  Sales.SalesPerson
order by
  SalesYTD desc
offset 0 rows fetch next 3 rows only


-- rank 4～6
select
  *
from
  Sales.SalesPerson
order by
  SalesYTD desc
offset
  3 rows fetch next 3 rows only


