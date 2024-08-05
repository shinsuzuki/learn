use AdventureWorks2022
-- coalesce演算子

-- 最初にNULLでないものを返す
select
  COALESCE(MiddleName, 'MiddleName is NULL') as MiddleName_check,
  *
from
  Person.Person

