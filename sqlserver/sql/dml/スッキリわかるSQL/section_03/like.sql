use AdventureWorks2022

-- LINE演算子
-- [%]: 任意の0文字以上の文字
-- [_]: 任意の一文字

-- 前方一致
select
  *
from
  Person.Person
where
  FirstName like 'du%'
order by
  FirstName

-- 後方一致
select
  *
from
  Person.Person
where
  FirstName like '%son'
order by
  FirstName

-- 含まれる
select
  *
from
  Person.Person
where
  FirstName like '%lin%'
order by
  FirstName
