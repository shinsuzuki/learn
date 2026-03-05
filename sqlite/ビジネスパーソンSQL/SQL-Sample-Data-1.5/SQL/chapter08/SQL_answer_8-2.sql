SELECT
    COUNT(DISTINCT o.order_id) AS '全体',
    COUNT(DISTINCT CASE WHEN u.gender = '男性' THEN o.order_id ELSE NULL END) AS '男性',
    COUNT(DISTINCT CASE WHEN u.gender = '女性' THEN o.order_id ELSE NULL END) AS '女性'
FROM
    orders AS o
    LEFT JOIN users AS u ON o.user_id = u.user_id
