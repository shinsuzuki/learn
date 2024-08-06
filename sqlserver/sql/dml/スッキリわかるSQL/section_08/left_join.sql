use AdventureWorks2022
-- 外部結合

-- left outer join
select 
  p.ProductID,
  pd.DocumentNode
from 
  Production.Product as p
  left outer join Production.ProductDocument as pd
  on p.ProductID = pd.ProductID
