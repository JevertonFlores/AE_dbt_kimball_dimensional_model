WITH intermediate AS (
    SELECT DISTINCT
        *
    FROM {{ ref('int_order_types') }}
),

treated AS (
    SELECT
        ROW_NUMBER() OVER (ORDER BY order_type_id) AS sk_order_type
        ,order_type_id
        ,type
        ,frequency
    FROM intermediate
)

SELECT
    *
FROM treated