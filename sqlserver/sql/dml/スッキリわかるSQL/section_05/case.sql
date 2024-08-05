use AdventureWorks2022
-- case演算子

-- 文字
select
  BusinessEntityID,
  Title,
  case Title
    when 'Mr' then N'男性'
    when 'Mr.' then N'男性'
    when 'Ms' then N'女性'
    when 'Ms.' then N'女性'
    when 'Sra.' then N'女性（セニョリータ）'
    else N'未設定'
  end as TitleJP
from
  Person.Person
order by
  BusinessEntityID


-- 条件式
select
  BusinessEntityID,
  Bonus,
  SalesYTD,
  case
    when Bonus >= 3000 then 'RANK_A'
    when Bonus >= 2000 then 'RANK_B'
    when Bonus >= 1000 then 'RANK_C'
    else 'RANK_D'
  end as BonusClass
from
  Sales.SalesPerson
order by
  SalesYTD desc
