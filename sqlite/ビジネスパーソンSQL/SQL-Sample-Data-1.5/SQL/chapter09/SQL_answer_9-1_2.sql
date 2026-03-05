WITH hml_users AS(
    SELECT
        user_id,
        CASE
            WHEN COUNT(DISTINCT order_id) >= 500 THEN 'ヘビー'
            WHEN COUNT(DISTINCT order_id) >= 300 THEN 'ミドル'
            ELSE 'ライト'
        END AS hml
    FROM
        orders
    WHERE
        user_id IS NOT NULL
		AND order_date BETWEEN '2022-01-01' AND '2022-12-31'
        AND is_canceled = 0
    GROUP BY
        user_id
)

SELECT
    hml,
    COUNT(DISTINCT user_id) AS uu
FROM
    hml_users
GROUP BY
    hml
