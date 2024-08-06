use MySample

update customer with(nowait) -- lock.sql側実行中に、これを実行すると待たずにエラーとなる
set
  point = 200
where
  id = 2