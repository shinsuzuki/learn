SELECT
    order_id,
    user_id
FROM
    orders
WHERE
    user_id IS NULL
LIMIT 10
