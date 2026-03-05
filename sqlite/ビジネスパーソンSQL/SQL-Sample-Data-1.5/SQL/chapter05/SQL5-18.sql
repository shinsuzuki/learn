SELECT
    large_category,
    COUNT(*)
FROM
    products
WHERE
    COUNT(*) >= 5
GROUP BY
    large_category
