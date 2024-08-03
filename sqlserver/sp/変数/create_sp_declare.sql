-- 呼び出し
-- EXEC sp_declare_test

--------------------------------------------------------------------------------
-- sample: 変数定義
--------------------------------------------------------------------------------
USE [AdventureWorks2022]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 定義済みの場合は削除
DROP PROCEDURE IF EXISTS dbo.sp_declare_test
GO

CREATE PROCEDURE sp_declare_test
AS
BEGIN
    --変数定義、設定
    DECLARE @myValue int
    SET @myValue = 100
    DECLARE @myName nvarchar(50) = 'kawasaki'

    PRINT '@myValue:' + CONVERT(nvarchar,@myValue)
    PRINT '@myName:' + @myName
    RETURN
END
GO