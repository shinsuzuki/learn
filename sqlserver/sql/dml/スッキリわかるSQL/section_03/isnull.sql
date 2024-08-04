use AdventureWorks2022
-- NULLの判定

-- is null
select
  *
from
	Person.Person
where
  BusinessEntityID between 1 and 5
  and
  MiddleName is null
order by
  BusinessEntityID

-- is not null
select
  *
from
  Person.Person
where
  BusinessEntityID between 1 and 5
  and
  MiddleName is not null
order by
  BusinessEntityID
