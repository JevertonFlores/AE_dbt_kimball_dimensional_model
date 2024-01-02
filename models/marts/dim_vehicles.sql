WITH intermediate AS (
    SELECT
        *
    FROM {{ ref('int_order_items') }}
),

distinct_vehicles as (
    SELECT DISTINCT
        manufacturer
        ,model
    FROM intermediate
),

treated AS (
    SELECT
        ROW_NUMBER() OVER (ORDER BY manufacturer, model) AS sk_vehicle
        ,manufacturer
        ,model
    FROM distinct_vehicles
)

SELECT
    *
FROM treated