use AdventureWorks2022

-- EXCEPT演算子（差分）
-- 全体からMiddleNameがA,B,Zのものを引く
select FirstName, MiddleName from Person.Person
except
select FirstName, MiddleName from Person.Person where MiddleName in('A','B','Z')
order by
  FirstName
