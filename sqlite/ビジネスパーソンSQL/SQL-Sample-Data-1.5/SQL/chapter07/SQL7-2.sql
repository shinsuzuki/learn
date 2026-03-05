SELECT
    'max_birth' AS data_key,
    MAX(birth) AS data_value
FROM
    users
 
UNION ALL

SELECT
    'max_birth' AS data_key,
    MIN(birth) AS data_value
FROM
    users
