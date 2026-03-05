SELECT
    product_id,
    name,
    price,
    large_category
FROM
    products
ORDER BY
    price DESC,
    large_category ASC
