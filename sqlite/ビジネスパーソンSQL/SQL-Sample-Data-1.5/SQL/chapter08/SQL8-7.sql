SELECT
    COUNT(DISTINCT CASE WHEN p.large_category = '食品' THEN o.order_id ELSE NULL END) AS '食品',
    COUNT(DISTINCT CASE WHEN p.small_category = '水' THEN o.order_id ELSE NULL END) AS '水'
FROM
    orders AS o
    LEFT JOIN products AS p ON o.order_product_id = p.product_id
