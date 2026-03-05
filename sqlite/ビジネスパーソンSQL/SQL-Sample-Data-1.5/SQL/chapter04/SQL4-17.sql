SELECT
    COUNT(*) AS count_1,
    COUNT(large_category) AS count_2,
    COUNT(DISTINCT large_category) AS count_3
FROM
    products
