--use MySample

-- ビュー作成
create view v_家計簿_入出金 as
  select 入金額,出金額 from 家計簿

-- ビュー削除
-- drop view v_家計簿_入出金