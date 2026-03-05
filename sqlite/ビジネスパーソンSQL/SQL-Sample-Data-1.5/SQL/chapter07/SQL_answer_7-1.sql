SELECT
    'max_price' AS data_key,
    MAX(price) AS data_value
FROM
    products

UNION ALL

SELECT
    'min_price' AS data_key,
    MIN(price) AS data_value
FROM
    products

UNION ALL

SELECT
    'avg_price' AS data_key,
    AVG(price) AS data_value
FROM
    products
