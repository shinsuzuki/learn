SELECT DISTINCT
    user_id
FROM
    orders AS o2
    LEFT JOIN products AS p2 ON o2.order_product_id = p2.product_id
WHERE
    p2.name = 'トートバッグ'
    AND o2.user_id IS NOT NULL
