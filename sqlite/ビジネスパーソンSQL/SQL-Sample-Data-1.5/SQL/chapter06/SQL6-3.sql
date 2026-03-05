SELECT
    order_id,
    o.user_id,
    gender,
    birth
FROM
    orders AS o
    INNER JOIN users AS u ON o.user_id = u.user_id
LIMIT 10
