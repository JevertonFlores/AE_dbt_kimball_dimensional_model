WITH source AS (
    SELECT
        *
    FROM {{ source('seeds', 'employees') }}
)

SELECT
    id
    ,departament_id
    ,company_branches_id
    ,departament
    ,first_name
    ,last_name
    ,gender
    ,email
FROM source