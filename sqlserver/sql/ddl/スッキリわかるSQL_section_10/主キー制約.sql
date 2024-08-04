use MySample

-- 主キー制約１（キーを一つ）
create table 費目 (
    ID int PRIMARY KEY,
    名前 nvarchar(40) UNIQUE
)


-- 主キー制約２（キーを複数）
create table 費目 (
    ID int,
    名前 nvarchar(40) unique,
    PRIMARY KEY(ID,名前)
)