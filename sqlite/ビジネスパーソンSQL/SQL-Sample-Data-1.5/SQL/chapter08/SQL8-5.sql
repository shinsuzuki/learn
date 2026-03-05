SELECT
    COUNT(DISTINCT o.order_id) AS order_count
FROM
    orders AS o
    LEFT JOIN products AS p ON o.order_product_id = p.product_id
WHERE
    p.large_category = '食品'
