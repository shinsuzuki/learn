SELECT
    COUNT(*)
FROM
    orders AS o
    LEFT JOIN users AS u ON o.user_id = u.user_id
