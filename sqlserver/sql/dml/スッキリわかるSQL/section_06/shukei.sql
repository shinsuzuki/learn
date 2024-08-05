use AdventureWorks2022

-- 集計関数
-- { sum | max | min | avg | count }
-- 呼び出しはSelect句、OrderBy句、Having句に記述可能
-- 集計関数はNULLを無視する（集計に影響を与えない、count(*)のみ含んでカウントする）

-- sum,max,min,avg,count
select
  sum(Bonus) as SumBonus,
  max(Bonus) as MaxBonus,
  min(Bonus) as MinBnous,
  avg(Bonus) as AvgBonus,
  count(*) as cntAster,          -- [cnt=17]: count(*) はnullをカウントする
  count(TerritoryID) as cntItem  -- [cnt=14]: count(列名)はnullをカウントしない
from
  Sales.SalesPerson


-- group（単）
select
  FirstName,                        -- グループ化の基準列
  count(*) as SameFirstNameCount    -- 集計関数
from
  Person.Person
where
  MiddleName = 'A'
group by
  FirstName
having
  count(FirstName) >= 9
order by
  count(FirstName) desc

-- group（複）
select
  count(*),
  FirstName,
  MiddleName
from
  Person.Person
group by
  FirstName,
  MiddleName
having
  count(*) > 8
order by
  count(*) desc,
  FirstName,
  MiddleName
