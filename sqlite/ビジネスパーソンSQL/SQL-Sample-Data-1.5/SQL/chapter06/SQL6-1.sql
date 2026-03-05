SELECT
    o.order_id,
    o.user_id,
    u.gender,
    u.birth
FROM
    orders AS o
    INNER JOIN users AS u ON o.user_id = u.user_id
LIMIT 10
