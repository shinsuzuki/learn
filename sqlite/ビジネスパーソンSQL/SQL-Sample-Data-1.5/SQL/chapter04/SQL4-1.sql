SELECT
    birth,
    CAST(birth AS TEXT) AS birth_text
FROM
    users
