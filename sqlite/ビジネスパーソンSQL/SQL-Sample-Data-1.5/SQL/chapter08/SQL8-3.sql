SELECT
    o.user_id,
    SUM(p.price) AS total_price,
    CASE
        WHEN SUM(p.price) >= 200000 THEN 'ミドル'
        WHEN SUM(p.price) >= 1000000 THEN 'ヘビー'
        WHEN SUM(p.price) < 200000 THEN 'ライト'
        ELSE 'その他'
    END AS hml
FROM
    orders AS o
    LEFT JOIN products AS p ON o.order_product_id = p.product_id
WHERE
    o.user_id IS NOT NULL
    AND o.order_date BETWEEN '2022-01-01' AND '2022-12-31'
    AND o.is_canceled = 0
GROUP BY
    o.user_id
