use MySample
-- index
-- [メリット - 有効な場合]
--   Where句で使用するカラム（完全一致、前方一致）
--   Order By句で使用するカラム
--   Joinの結合で使用するカラム
--
-- [デメリット]
--   索引情報を保存するためディスク容量が必要
--   CUD時にインデックスを書き換えるため、オーバーヘッドが増える


-- create index
create index IX_費目 on 家計簿 (費目ID)
create index IX_日付 on 家計簿 (日付)

-- drop index
drop index IX_費目 on 家計簿
drop index IX_日付 on 家計簿
