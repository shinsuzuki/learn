use MySample

-- 制約,default, not null, unique

-- default制約, not null制約
create table 家計簿 (
    日付 date not null,
    費目ID int,
    メモ nvarchar(100) default '不明' not null,
    入金額 int default 0 check(入金額 >= 0),
    出金額 int default 0 check(出金額 >= 0)
)

-- unique制約
create table 費目 (
    id int,
    名前 nvarchar(40) unique
)