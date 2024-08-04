use AdventureWorks2022

-- IN演算子

-- IN句
select
  *
from
  Person.Person
where
  MiddleName in ('P.', 'T.')


-- NOT IN句
select
  *
from
  Person.Person
where
  MiddleName not in ('A', 'A.', 'Z', 'Z.')
order by
  MiddleName