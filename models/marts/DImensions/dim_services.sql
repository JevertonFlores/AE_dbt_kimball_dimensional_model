WITH intermediate AS (
    SELECT
        *
    FROM {{ ref('int_order_items') }}
),

distinct_services as (
    SELECT DISTINCT
        status
    FROM intermediate
    WHERE order_type_id IN (2, 3)
),

treated AS (
    SELECT
        ROW_NUMBER() OVER (ORDER BY status) AS sk_service
        ,status AS service
    FROM distinct_services
)

SELECT
    *
FROM treated