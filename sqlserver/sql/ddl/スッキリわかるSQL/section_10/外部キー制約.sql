use MySample

-- 外部キーを設定
-- 設定1（単）
create table 家計簿 (
    日付 datetime not null,
    費目ID int REFERENCES 費目 (ID),
    メモ nvarchar(40) default '不明' not null,
    入金額 int default 0 check(入金額 >= 0),
    出金額 int default 0 check(出金額 >= 0)
)

-- 設定2（複数）
create table 家計簿 (
    日付 datetime not null,
    費目ID int,
    メモ nvarchar(40) default '不明' not null,
    入金額 int default 0 check(入金額 >= 0),
    出金額 int default 0 check(出金額 >= 0)
    FOREIGN KEY (費目ID) REFERENCES 費目 (ID)
)

