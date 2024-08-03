-- 呼び出し
-- EXEC sp_check_param_test

--------------------------------------------------------------------------------
-- sample: 入力パラメータチェック
--------------------------------------------------------------------------------
USE [AdventureWorks2022]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 定義済みの場合は削除
DROP PROCEDURE IF EXISTS dbo.sp_check_param_test
GO

CREATE PROCEDURE sp_check_param_test
(
    @param1 int = null,
    @param2 nvarchar(10) = null
)
AS
BEGIN
    if @param1 is null
    begin
        print 'param1 no set.'
        return (-1)
    end

    if @param2 is null
    begin
        print 'param2 no set.'
        return (-1)
    end

    PRINT 'parameter check ok'

    RETURN
END
GO