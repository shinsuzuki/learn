SELECT
    order_id,
    order_date
FROM
    orders
WHERE
    order_date = '2022-01-01'
LIMIT 10
