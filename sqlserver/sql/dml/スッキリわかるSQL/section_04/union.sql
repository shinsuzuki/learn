use AdventureWorks2022

-- UNION演算子（和集合）
-- ALLあり(重複なし）
select
  FirstName from Person.Person where MiddleName = 'A'
union
select
  FirstName from Person.Person where MiddleName = 'Z'
order by
  FirstName


-- ALLなし(重複あり）
select
  FirstName from Person.Person where MiddleName = 'A'
union all
select
  FirstName from Person.Person where MiddleName = 'Z'
order by
  FirstName

