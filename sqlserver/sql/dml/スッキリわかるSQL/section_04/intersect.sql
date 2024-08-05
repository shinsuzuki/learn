use AdventureWorks2022
-- intersect（積集合）

select FirstName from Person.Person where MiddleName = 'A'
intersect
select FirstName from Person.Person where MiddleName = 'Z'
order by
  FirstName
