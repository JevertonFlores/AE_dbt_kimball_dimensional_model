WITH intermediate AS (
    SELECT DISTINCT
        *
    FROM {{ ref('int_company_branches') }}
),

treated AS (
    SELECT
        ROW_NUMBER() OVER (ORDER BY company_branch_id) AS sk_company_branch
        ,company_branch_id
        ,country
        ,state
        ,city
        ,name
    FROM intermediate
)

SELECT
    *
FROM treated