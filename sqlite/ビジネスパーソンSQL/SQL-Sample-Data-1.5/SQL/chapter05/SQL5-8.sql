SELECT
    product_id,
    name,
    large_category
FROM
    products
WHERE
    large_category = '食品'
    OR large_category = '日用品'
