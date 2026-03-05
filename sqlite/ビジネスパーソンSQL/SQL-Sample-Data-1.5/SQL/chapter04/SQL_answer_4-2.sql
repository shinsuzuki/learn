SELECT
    large_category,
    AVG(price) AS avg_price
FROM
    products
GROUP BY
    large_category
