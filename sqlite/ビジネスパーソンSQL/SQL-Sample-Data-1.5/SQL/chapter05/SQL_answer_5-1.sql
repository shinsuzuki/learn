SELECT
    large_category,
    COUNT(*)
FROM
    products
WHERE
    price <= 1000
GROUP BY
    large_category
