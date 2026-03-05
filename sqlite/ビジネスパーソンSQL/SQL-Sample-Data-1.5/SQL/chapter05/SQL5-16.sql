SELECT
    product_id,
    name,
    large_category
FROM
    products
WHERE
    large_category IN ('食品', '日用品', '電化製品')
