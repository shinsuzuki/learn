use MySample

-- 変更
-- 項目を追加
alter table 家計簿 add 関連日 datetime

-- 項目を変更
alter table 家計簿 alter column メモ nvarchar(100)

-- 項目を削除
-- alter table 家計簿 drop column 関連日