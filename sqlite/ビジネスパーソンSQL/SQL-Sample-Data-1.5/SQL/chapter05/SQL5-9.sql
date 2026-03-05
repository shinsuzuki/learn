SELECT
    product_id,
    name,
    price
FROM
    products
WHERE
    price <= 1000
    AND price >= 500
