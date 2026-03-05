SELECT
    large_category,
    COUNT(*)
FROM
    products
GROUP BY
    large_category
