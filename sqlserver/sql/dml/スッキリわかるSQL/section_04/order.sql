use AdventureWorks2022

-- order by演算子
-- 昇順
select
  *
from
  Person.Person
order by
  FirstName asc

-- 降順
select
  *
from
  Person.Person
order by
  FirstName desc
