WITH stg AS (
    SELECT
        *
    FROM {{ ref('stg_orders') }}
),

treatment_types AS (
    SELECT
        id::INTEGER AS order_id
        ,departament_id
        ,employee_id
        ,order_type_id
        ,customer_id
        ,TO_TIMESTAMP(order_date, 'YYYY-MM-DD HH24:MI:SS') AS order_date
        ,TO_TIMESTAMP(return_date, 'YYYY-MM-DD HH24:MI:SS') AS return_date
    FROM stg
    WHERE customer_id <> 'id'
    -- Foram encontrados dois registros com customer_id mal formatados como string 'id' que estão sendo removidos.
),

treated AS (
    SELECT
        order_id
        ,departament_id
        ,order_type_id
        ,customer_id::INTEGER AS customer_id
        ,order_date
        ,return_date
        ,(return_date::DATE - order_date::DATE) AS days_diff
        ,ROUND(EXTRACT(EPOCH FROM return_date - order_date) / 3600) AS diff_hours
    FROM treatment_types
)

SELECT
    *
FROM treated