SELECT
    o.user_id,
    SUM(p.price) AS total_price,
    COUNT(*) AS total_orders
FROM
    orders o
    LEFT JOIN products p ON o.order_product_id = p.product_id
WHERE
	o.is_canceled = 0
GROUP BY
    o.user_id
ORDER BY
    total_price DESC
