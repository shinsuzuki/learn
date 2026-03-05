SELECT
    DATE() AS now_date,
    SUBSTR(DATE(), 1, 4) AS year,
    SUBSTR(DATE(), 6, 2) AS month
FROM
    users
