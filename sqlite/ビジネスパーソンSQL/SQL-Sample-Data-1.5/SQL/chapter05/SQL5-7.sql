SELECT
    order_id,
    order_date,
    is_discounted
FROM
    orders
WHERE
    order_date <= '2022-01-03'
    AND is_discounted = 1
LIMIT 10
