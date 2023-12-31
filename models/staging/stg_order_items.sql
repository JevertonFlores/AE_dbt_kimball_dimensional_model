WITH source AS (
    SELECT
        *
    FROM {{source('sales_car', 'order_items')}}
)

SELECT
    id
    ,order_id
    ,order_type_id
    ,item
FROM source