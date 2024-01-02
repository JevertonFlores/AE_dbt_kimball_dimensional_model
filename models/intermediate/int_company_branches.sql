WITH stg AS (
    SELECT
        *
    FROM {{ ref('stg_company_branches') }}
),

treated AS (
SELECT DISTINCT
    id AS company_branch_id
    ,country_code
    ,UPPER(country) AS country
    ,state
    ,UPPER(city) AS city
    ,TRIM(' ' FROM 'LOJA - ' || SUBSTRING(UPPER(name) FROM POSITION('-' IN NAME) + 2)) AS name
    ,latitude
    ,longitude
    ,phone
FROM stg
)

SELECT
    *
FROM treated