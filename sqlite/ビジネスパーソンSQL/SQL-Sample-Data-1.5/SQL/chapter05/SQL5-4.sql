SELECT
    order_id,
    order_date
FROM
    orders
WHERE
    order_date <> '2022-05-10'
LIMIT 10
