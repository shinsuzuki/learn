-- 呼び出し
-- EXEC sp_exception_test

--------------------------------------------------------------------------------
-- sample: 例外
--------------------------------------------------------------------------------
USE [AdventureWorks2022]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 定義済みの場合は削除
DROP PROCEDURE IF EXISTS dbo.sp_exception_test
GO

CREATE PROCEDURE sp_exception_test
AS
BEGIN
    SET XACT_ABORT ON   -- 制約違反のときにロールバックさせるため
    BEGIN TRY
        BEGIN TRAN
            -- 一意制約エラー
            INSERT INTO Person.Person VALUES(1, 'EM' ,0 ,NULL ,'Aoi', 'K', 'Hoshi', NULL, 0, NULL, NULL, 'd8763459-8aa8-47cc-aff7-c9079af79999', '2021/10/2 12:13:14')

            -- カスタムエラーを発生させる（ERROR_MESSAGE,ERROR_SEVERITY,ERROR_STATE）
            -- エラー重大度レベルは「16」がユーザー定義エラー用として空いている
            -- RAISERROR('CustomError!', 16, 1)
            -- WITH LOG    -- with logを付けるとWindowsのイベントログに出力される
        COMMIT TRAN
    END TRY
    BEGIN CATCH
        -- THROW -- 再スローもあり対応
        ROLLBACK TRAN
        SELECT
            ERROR_NUMBER() as ERROR_NUMBER ,        -- エラー番号
            ERROR_MESSAGE() as ERROR_MESSAGE,       -- エラーメッセージ
            ERROR_SEVERITY() as ERROR_SEVERITY,     -- エラー重大度レベル
            ERROR_STATE() as ERROR_STATE,           -- エラー状態番号
            ERROR_LINE() as ERROR_LINE,             -- エラー発生行番号
            ERROR_PROCEDURE() as ERROR_PROCEDURE    -- エラーが発生したプロシージャ

    END CATCH
    SET XACT_ABORT OFF

    RETURN
END
GO