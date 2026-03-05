SELECT
    '2022年1月' AS month,
    COUNT(DISTINCT order_id) AS order_count
FROM
    orders
WHERE
    order_date BETWEEN '2022-01-01' AND '2022-01-31'
    AND is_canceled = 0

UNION ALL

SELECT
    '2022年12月' AS month,
    COUNT(DISTINCT order_id) AS order_count
FROM
    orders
WHERE
    order_date BETWEEN '2022-12-01' AND '2022-12-31'
    AND is_canceled = 0
