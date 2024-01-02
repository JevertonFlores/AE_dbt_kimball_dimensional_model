WITH intermediate AS (
    SELECT
        *
    FROM {{ ref('int_order_status') }}
),

distinct_status AS (
    SELECT DISTINCT
        order_status
    FROM intermediate
),

treated AS (
    SELECT
        ROW_NUMBER() OVER (ORDER BY order_status) AS sk_order_status
        ,order_status
    FROM distinct_status
)

SELECT
    *
FROM treated