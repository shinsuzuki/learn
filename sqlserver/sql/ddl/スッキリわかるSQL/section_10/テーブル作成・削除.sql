use MySample

-- テーブル作成、デフォルト設定
create table 家計簿 (
    日付 datetime,
    項目ID int,
    メモ NVARCHAR(100) default '不明',
    入金額 int default 0,
    出金額 int default 0,
)

-- テーブル削除
drop table 家計簿

