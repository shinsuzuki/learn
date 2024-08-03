-- 呼び出し
-- EXEC sp_control_test

--------------------------------------------------------------------------------
-- sample: 制御文
--------------------------------------------------------------------------------
USE [AdventureWorks2022]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 定義済みの場合は削除
DROP PROCEDURE IF EXISTS dbo.sp_control_test
GO

CREATE PROCEDURE sp_control_test
AS
BEGIN
    --変数定義、設定
    DECLARE @myValue int
    SET @myValue = 100
    DECLARE @myName nvarchar(50) = 'kawasaki'


    -- IF
    PRINT '==== IF ====='
    IF (@myValue = 100)
        BEGIN
            PRINT 'OK'
        END
    ELSE
        BEGIN
            PRINT 'NG'
        END

    PRINT '==== IF EXISTS ====='
    IF EXISTS(select * from Person.Person where BusinessEntityID = -1)
        Begin
            PRINT 'Person.Person exists'
        END
    ELSE
        BEGIN
            PRINT 'Person.Person no exists'
        END

    -- WHILE
    PRINT '==== WHILE ====='
    DECLARE @loop int = 2
    WHILE(@loop > 0)
        BEGIN
            PRINT @loop
            set @loop -= 1
        END

    -- CASE
    PRINT '==== CASE ====='
    DECLARE @type int = 0
    DECLARE @msg nvarchar(20)

    set @msg =  CASE @type
                    when 0 then 'good morning'
                    when 1 then 'hello'
                    else 'good night'
                END

    PRINT @msg

    -- GOTO
    PRINT '==== GOTO ====='
    GOTO jump_saki
    PRINT 'GOTOのため処理されない'

    jump_saki:
    PRINT 'GOTO後'

    RETURN
END
GO