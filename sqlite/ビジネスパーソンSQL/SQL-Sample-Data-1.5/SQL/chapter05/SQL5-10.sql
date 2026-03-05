SELECT
    product_id,
    name,
    price
FROM
    products
WHERE
    price BETWEEN 500 AND 1000
