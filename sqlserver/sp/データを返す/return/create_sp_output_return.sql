-- 呼び出し
--  DECLARE @result int
--  EXEC sp_output_param_test 10,@result OUTPUT
--  SELECT @result

--------------------------------------------------------------------------------
-- sample: Returnコードを利用してデータを返す
--------------------------------------------------------------------------------
USE [AdventureWorks2022]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 定義済みの場合は削除
DROP PROCEDURE IF EXISTS dbo.sp_output_return_test
GO

CREATE PROCEDURE sp_output_return_test
(
    @check as INT
)
AS
BEGIN
    DECLARE @baseValue INT = 100

    IF (@check = 0)
        BEGIN
            RETURN (@baseValue  + 0)
        END
    ELSE IF (@check = 1)
        BEGIN
            RETURN (@baseValue  + 1)
        END
    ELSE
        BEGIN
            RETURN (-1)
        END
END
GO