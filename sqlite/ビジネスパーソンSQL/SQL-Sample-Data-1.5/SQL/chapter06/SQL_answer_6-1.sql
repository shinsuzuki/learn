SELECT
    SUM(p.price),
    COUNT(*)
FROM
    orders AS o
    LEFT JOIN products AS p ON o.order_product_id = p.product_id
WHERE
    o.order_date = '2022-01-01'
    AND o.is_canceled = 0
