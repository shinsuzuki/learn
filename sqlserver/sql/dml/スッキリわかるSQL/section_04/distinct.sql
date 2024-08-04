use AdventureWorks2022

-- distinct演算子
select
  distinct FirstName
from
  Person.Person
where
  BusinessEntityID between 1 and 100



