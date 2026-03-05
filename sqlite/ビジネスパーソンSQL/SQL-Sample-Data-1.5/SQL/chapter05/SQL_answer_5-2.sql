SELECT
    large_category,
    COUNT(*) AS category_count
FROM
    products
GROUP BY
    large_category
HAVING
    COUNT(*) >= 5
ORDER BY
    COUNT(*) DESC
