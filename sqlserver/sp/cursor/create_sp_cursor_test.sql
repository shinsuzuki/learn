-- 呼び出し
-- DECLARE @result int
-- EXEC @result = sp_cursor_test 10,100
-- SELECT @result


USE [AdventureWorks2022]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 定義済みの場合は削除
DROP PROCEDURE IF EXISTS dbo.sp_cursor_test
GO

CREATE PROCEDURE sp_cursor_test
(
    @fromBusinessEntityID as INT,
    @toBusinessEntityID as INT
)
AS
BEGIN
    -- 変数定義
    DECLARE @BusinessEntityID INT
    DECLARE @FirstName NVARCHAR(50)
    DECLARE @LastName NVARCHAR(50)

    -- SET
    DECLARE @MySpName NVARCHAR(20)
    SET @MySpName = '==== cursor test sp ===='
    PRINT @MySpName

    -- カーソル定義
    DECLARE MyCur CURSOR FOR
        SELECT
            BusinessEntityID,
            FirstName,
            LastName
        FROM
            Person.Person
        WHERE
            @fromBusinessEntityID < BusinessEntityID
            AND
            BusinessEntityID < @toBusinessEntityID

    -- カーソルを開く
    OPEN MyCur
        -- 行を取得
        FETCH NEXT FROM MyCur INTO @BusinessEntityID, @FirstName, @LastName

        -- ループ
        WHILE(@@fetch_status = 0)
        BEGIN
            PRINT CONVERT(NVARCHAR, @BusinessEntityID)  + ':'+ @FirstName + ' - ' + @LastName
            -- 行を取得
            FETCH NEXT FROM MyCur INTO @BusinessEntityID, @FirstName, @LastName
        END

    -- カーソルを閉じる
    CLOSE MyCur
    DEALLOCATE MyCur

    RETURN (0)
END
GO