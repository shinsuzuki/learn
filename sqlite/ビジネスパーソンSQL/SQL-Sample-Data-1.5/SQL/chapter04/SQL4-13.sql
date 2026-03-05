SELECT
    large_category,
    medium_category,
    COUNT(*)
FROM
    products
GROUP BY
    large_category,
    medium_category
