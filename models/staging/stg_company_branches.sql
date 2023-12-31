WITH source AS (
    SELECT
        *
    FROM {{source('sales_car', 'company_branches')}}
)

SELECT
    id
    ,country_code
    ,country
    ,state
    ,city
    ,name
    ,latitude
    ,longitude
    ,phone
FROM source