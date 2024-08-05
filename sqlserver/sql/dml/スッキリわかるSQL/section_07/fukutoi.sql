use AdventureWorks2022
-- 複問い合わせ

-- 値
select
  *
from
  Sales.SalesPerson
where
  Bonus = (select max(Bonus) from Sales.SalesPerson)


-- 配列
select
  a.*
from
  Sales.SalesOrderDetail as a
where
  a. SalesOrderID in (
    select
      coalesce(b.SalesOrderID, 0) -- null を返さない対応
    from
      Sales.SalesOrderDetail as b
    where
      b.SalesOrderID = 43659
    )


-- 表（Selectで表を作成、それから取得）
select sum(a.SalesYTD) as item_4000_5000_over from
(
  select SalesYTD from Sales.SalesPerson where TerritoryID = 5
  union
  select SalesYTD from Sales.SalesPerson where TerritoryID = 10
) as a
