SELECT
    o.user_id,
    p.product_id,
    p.name,
    p.price
FROM
    orders AS o
    LEFT JOIN products AS p ON o.order_product_id = p.product_id
LIMIT 10
