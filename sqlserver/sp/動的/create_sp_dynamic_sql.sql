-- 呼び出し
-- EXEC sp_dynamic_sql_test

--------------------------------------------------------------------------------
-- sample: 動的SQL
--------------------------------------------------------------------------------
USE [AdventureWorks2022]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 定義済みの場合は削除
DROP PROCEDURE IF EXISTS dbo.sp_dynamic_sql_test
GO

CREATE PROCEDURE sp_dynamic_sql_test
AS
BEGIN
    ---- 動的１（exec）
    -- 文字として記述
    EXEC('select top 3 * from Person.Person')

    -- カラムやテーブルを変数化
    DECLARE @tableName nvarchar(20) = 'Person.Person'
    DECLARE @columnName nvarchar(20) = 'FirstName'
    EXEC('select top 3 ' + @columnName + ' from ' + @tableName)

    ---- 動的２（sp_executesql）
    -- sp_executesqlはSQLの文字列連結が完了したものを設定
    DECLARE @tableName2 nvarchar(20) = 'Person.Person'
    DECLARE @columnName2 nvarchar(20) = 'FirstName'
    DECLARE @sql nvarchar(100) = N'select top 3 ' + @columnName2 + ' from '  + @tableName2
    EXEC sp_executesql @sql

    -- where句にパラメータを設定
    DECLARE @sql2 nvarchar(100) = N'select FirstName, LastName from Person.Person where FirstName like @p1 and LastName like @p2'
    EXEC sp_executesql @sql2, N'@p1 nvarchar(50), @p2 nvarchar(50)',@p1='A%', @p2='M%'


    RETURN
END
GO