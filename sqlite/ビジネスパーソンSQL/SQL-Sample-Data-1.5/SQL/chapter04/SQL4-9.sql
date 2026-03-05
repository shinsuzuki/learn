SELECT
    COUNT(user_id) AS user_id_count,
    COUNT(*),
    COUNT(1)
FROM
    orders
