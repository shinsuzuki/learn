use MySample

-- 登録（単）
insert into customer
  ( id, name, old, point, created_at )
  values
  (  10, 'name-a', 23, 100,GETDATE() )



-- 登録（複数）
insert into customer
  ( id, name, old, point, created_at )
  values
  ( 10, 'name-a', 23, 100, GETDATE() ),
  ( 11, 'name-b', 24, 100, GETDATE() ),
  ( 12, 'name-c', 25, 100, GETDATE() )

