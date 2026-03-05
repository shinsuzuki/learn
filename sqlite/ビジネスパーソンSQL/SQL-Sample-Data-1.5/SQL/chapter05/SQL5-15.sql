SELECT
    product_id,
    name,
    large_category
FROM
    products
WHERE
    large_category = '食品'
    OR large_category = '日用品'
    OR large_category = '電化製品'
