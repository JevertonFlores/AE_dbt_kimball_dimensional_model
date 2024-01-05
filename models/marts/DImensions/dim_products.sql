WITH intermediate AS (
    SELECT
        *
    FROM {{ ref('int_order_items') }}
),

distinct_products as (
    SELECT DISTINCT
        status
    FROM intermediate
    WHERE order_type_id = 4
),

treated AS (
    SELECT
        ROW_NUMBER() OVER (ORDER BY status) AS sk_product
        ,status as product
    FROM distinct_products
)

SELECT
    *
FROM treated