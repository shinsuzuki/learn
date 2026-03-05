SELECT
    order_id,
    user_id
FROM
    orders
WHERE
    user_id IS NOT NULL
LIMIT 10
