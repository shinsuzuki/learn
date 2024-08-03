-- 呼び出し
-- EXEC sp_tmp_table_test

--------------------------------------------------------------------------------
-- sample: 一時テーブル
--------------------------------------------------------------------------------
USE [AdventureWorks2022]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 定義済みの場合は削除
DROP PROCEDURE IF EXISTS dbo.sp_tmp_table_test
GO

CREATE PROCEDURE sp_tmp_table_test
AS
BEGIN
    -- 一時テーブルは、次のように SELECT INTO ステートメントを利用して、SELECT ステートメントの検索結果をもとに作成することもできます。
    select * into #tmpEmailAddress from (
                select
                    p.FirstName + ' ' + p.LastName as Name,
                    e.EmailAddress
                from
                    Person.Person as p
                    inner join Person.EmailAddress as e on p.BusinessEntityID = e.BusinessEntityID
                ) as t1

    select * from #tmpEmailAddress
    drop table #tmpEmailAddress

    RETURN
END
GO