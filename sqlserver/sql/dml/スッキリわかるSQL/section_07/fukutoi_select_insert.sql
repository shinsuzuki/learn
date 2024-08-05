use MySample
-- 複問い合わせを利用した登録

-- 書き方1
declare @maxId int = (select max(id) from customer)

insert into
  customer(
    id,
    name,
    old,
    point,
    created_at
  )
  select
    @maxId + ROW_NUMBER() over(order by id),  -- idを増加
    'add_'+ a.name,
    a.old,
    a.point,
    getdate()
  from
    customer
  as a


-- 書き方2
insert into
  customer(
    id,
    name,
    old,
    point,
    created_at
  )
  select
    (select max(id) from customer) + ROW_NUMBER() over(order by id),  -- idを増加
    'add_'+ a.name,
    a.old,
    a.point,
    getdate()
  from
    customer
  as a

