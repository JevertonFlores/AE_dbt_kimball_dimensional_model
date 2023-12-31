WITH source AS (
    SELECT
        *
    FROM {{source('sales_car', 'orders')}}
)

SELECT
    id
    ,departament_id
    ,employee_id
    ,order_type_id
    ,order_status
    ,order_date
    ,return_date
    ,customer_id
FROM source