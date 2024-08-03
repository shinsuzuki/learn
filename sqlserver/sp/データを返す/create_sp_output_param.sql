-- 呼び出し
--  DECLARE @result nvarchar(20)
--  EXEC sp_output_param_test 10,@result OUTPUT
--  SELECT @result

--------------------------------------------------------------------------------
-- sample: 出力パラメータを使用して値を返す
--------------------------------------------------------------------------------
USE [AdventureWorks2022]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 定義済みの場合は削除
DROP PROCEDURE IF EXISTS dbo.sp_output_param_test
GO

CREATE PROCEDURE sp_output_param_test
(
    @SampleID as INT,
    @FirstName as NVARCHAR(20) OUTPUT
)
AS
BEGIN
    PRINT 'SampleID:' + CONVERT(nvarchar, @SampleID)
    select top 1 @FirstName = FirstName from Person.Person
    RETURN
END
GO