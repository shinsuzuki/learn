USE [MySample]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 定義済みの場合は削除
DROP TRIGGER IF EXISTS dbo.trg_customer_history_test
GO

CREATE TRIGGER trg_customer_history_test
ON customer
AFTER INSERT
AS
BEGIN
    INSERT INTO customer_history(
        id,
        name,
        created_at
    )
    SELECT
        id,
        name,
        GETDATE()
    FROM
        inserted
END
GO
