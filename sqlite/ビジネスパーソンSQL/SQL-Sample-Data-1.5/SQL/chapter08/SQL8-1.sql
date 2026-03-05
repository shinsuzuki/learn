SELECT
    o.user_id,
    SUM(p.price) AS total_price
FROM
    orders AS o
    LEFT JOIN products AS p ON o.order_product_id = p.product_id
WHERE
    o.user_id IS NOT NULL
    AND o.order_date BETWEEN '2022-01-01' AND '2022-12-31'
    AND o.is_canceled = 0
GROUP BY
    o.user_id
