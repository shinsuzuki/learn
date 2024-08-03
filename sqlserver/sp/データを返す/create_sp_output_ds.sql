-- 呼び出し
-- EXEC sp_output_ds_test

--------------------------------------------------------------------------------
-- sample: 結果セットを返す
--------------------------------------------------------------------------------
USE [AdventureWorks2022]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 定義済みの場合は削除
DROP PROCEDURE IF EXISTS dbo.sp_output_ds_test
GO

CREATE PROCEDURE sp_output_ds_test
AS
BEGIN
    -- selectの結果セットを返す
    select BusinessEntityID, FirstName, LastName, PersonType from Person.Person
    RETURN
END
GO