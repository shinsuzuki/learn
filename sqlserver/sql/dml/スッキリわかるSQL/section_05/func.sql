use AdventureWorks2022
-- 関数とか

-- LEN（文字列の長さ）
select FirstName, Len(FirstName ) as Len from Person.Person

-- TRIM,RTIM,LTIM（文字列から空白を取り除く）
select '[' + trim('    xxx    ') + ']'    -- '[xxx]'

-- REPLACE（文字列を置換）
select replace('apple', 'pp', 'zz')   -- 'azzle'

-- SUBSTRING（文字列から一部を抽出、startは1から、lengthは取得文字数）
select substring('abcdefg', 1, 4)   -- 'abcd'

-- CONCAT（文字列を連結）
select concat('abc', 'def')   -- 'abcdef'
select 'abc'+'def'            -- 'abcdef'

-- ROUND（指定桁数で四捨五入）
select round(1234.456, 2)      -- 1234.460, 少数2桁
select round(1234.456, 1)      -- 1234.500, 少数1桁
select round(1234.456, 0)      -- 1234.000, 少数0桁
select round(1234.456, -1)     -- 1230.000, 整数1桁
select round(1234.456, -2)     -- 1200.000, 整数2桁

-- ROUND（指定桁で切り捨てる）
select round(1234.456,  2, 1)  -- 1234.450, 少数2桁
select round(1234.456,  1, 1)  -- 1234.400, 少数1桁
select round(1234.456,  0, 1)  -- 1234.000, 少数0桁
select round(1234.456, -1, 1)  -- 1230.000, 整数1桁
select round(1234.456, -2, 1)  -- 1200.000, 整数2桁
select round(1234.456, -3, 1)  -- 1000.000, 整数3桁

-- POW
select power(2, 3)    -- 8

-- 日付
select GETDATE()                          -- 2024-08-05 17:28:51.860
select convert (varchar, GETDATE(), 111)  -- 2024/08/01
select convert (varchar, GETDATE(), 120)  -- 2024-08-01 17:27:20
select convert (varchar, GETDATE(), 112)  -- 20240801

-- 変換
select N'数値を文字列へ変換(convert):' + convert(varchar, 100)
select N'数値を文字列へ変換(cast):' + cast(100 as varchar)
select N'文字列を日付型へ変換(cast):↓' ; select cast('2024/8/8 12:32:45' as datetime) as Datetime

