use AdventureWorks2022
-- ALL/ANY演算子
-- 比較演算子: { = | <> | != | > | >= | !> | < | <= | !< }

-- ALL
-- ボーナスが売上高が300000以上の人達の中でTOPのデータ
select
  *
from
  Sales.SalesPerson
where
  SalesQuota is not null
  and
  Bonus >= all (select Bonus from Sales.SalesPerson where SalesQuota >= 300000)

-- ANY
-- ボーナスが売上高が300000以上の人達のボーナスの最小値より大きいデータ
select
  *
from
  Sales.SalesPerson
where
  SalesQuota is not null
  and
  Bonus >= any (select Bonus from Sales.SalesPerson where SalesQuota >= 300000)
