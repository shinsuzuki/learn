SELECT
    MAX(birth) AS max_birth,
    MIN(birth) AS min_birth,
    AVG(birth) AS avg_birth
FROM
    users
