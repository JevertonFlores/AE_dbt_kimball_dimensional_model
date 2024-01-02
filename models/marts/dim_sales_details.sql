WITH intermediate AS (
    SELECT
        *
    FROM {{ ref('int_order_items') }}
),

distinct_vehicles as (
    SELECT DISTINCT
        year_manufacturer
        ,color
        ,status
    FROM intermediate
    WHERE order_type_id = 1
),

treated AS (
    SELECT
        ROW_NUMBER() OVER (ORDER BY year_manufacturer, color, status) AS sk_vehicle
        ,year_manufacturer
        ,color
        ,status
    FROM distinct_vehicles
)

SELECT
    *
FROM treated