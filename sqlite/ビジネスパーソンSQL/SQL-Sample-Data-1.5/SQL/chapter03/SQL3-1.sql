SELECT
    large_category,
    COUNT(*)
FROM
    products
WHERE
    large_category = '食品'
GROUP BY
    large_category
ORDER BY
    large_category
