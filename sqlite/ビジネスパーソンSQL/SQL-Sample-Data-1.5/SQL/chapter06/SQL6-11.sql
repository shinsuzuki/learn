SELECT
    COUNT(*)
FROM
    users AS u
    LEFT JOIN orders AS o ON o.user_id = u.user_id
