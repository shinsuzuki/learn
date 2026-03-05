SELECT
    large_category,
    COUNT(*)
FROM
    products
GROUP BY
    large_category
HAVING
    COUNT(*) >= 5
