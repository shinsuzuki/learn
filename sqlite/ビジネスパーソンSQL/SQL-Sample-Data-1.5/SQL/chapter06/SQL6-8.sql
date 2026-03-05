SELECT
    COUNT(*)
FROM
    orders AS o
    INNER JOIN users AS u ON o.user_id = u.user_id
