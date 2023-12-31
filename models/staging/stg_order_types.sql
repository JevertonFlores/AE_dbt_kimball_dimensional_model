WITH source AS (
    SELECT
        *
    FROM {{source('sales_car', 'order_types')}}
)

SELECT
    id
    ,type
    ,frequency
FROM source