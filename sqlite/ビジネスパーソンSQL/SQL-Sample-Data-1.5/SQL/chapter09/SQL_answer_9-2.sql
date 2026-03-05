WITH bag_order AS (
    SELECT DISTINCT
        user_id
    FROM
        orders AS o2
        LEFT JOIN products AS p2 ON o2.order_product_id = p2.product_id
    WHERE
        p2.name = 'トートバッグ'
        AND o2.user_id IS NOT NULL
)

SELECT
    o.user_id,
    p.product_id,
    p.name,
    p.price
FROM
    orders AS o
    LEFT JOIN products AS p ON o.order_product_id = p.product_id
WHERE
    o.user_id IN (SELECT DISTINCT user_id FROM bag_order)
LIMIT 10
