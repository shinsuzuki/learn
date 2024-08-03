-- 呼び出し
-- EXEC sp_declare_test

--------------------------------------------------------------------------------
-- sample: CTEのサンプル
--------------------------------------------------------------------------------
USE [AdventureWorks2022]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 定義済みの場合は削除
DROP PROCEDURE IF EXISTS dbo.sp_cte_sample_test
GO

CREATE PROCEDURE sp_cte_sample_test
AS
BEGIN
    -- SELECT ステートメントで取得した結果に対して名前を付けることができる機能
    WITH tmpTable
        as (select
                p.BusinessEntityID as BusinessEntityID,
                p.FirstName +' '+ p.LastName as Name,
                e.EmailAddress
            from Person.Person as p
                inner join Person.EmailAddress as e on p.BusinessEntityID = e.BusinessEntityID)

    select BusinessEntityID, Name, EmailAddress from tmpTable where BusinessEntityID < 100
    RETURN
END
GO