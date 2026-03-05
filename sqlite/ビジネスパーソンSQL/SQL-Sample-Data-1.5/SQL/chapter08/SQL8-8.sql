SELECT
    '食品' as data_key,
    COUNT(DISTINCT o.order_id) as data_value
FROM
    orders AS o
    LEFT JOIN products AS p ON o.order_product_id = p.product_id
WHERE
    p.large_category = '食品'

UNION ALL
	
SELECT
    '水' as data_key,
    COUNT(DISTINCT o.order_id) as data_value
FROM
    orders AS o
    LEFT JOIN products AS p ON o.order_product_id = p.product_id
WHERE
    p.small_category = '水'
