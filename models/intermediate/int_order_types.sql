WITH stg AS (
    SELECT
        *
    FROM {{ ref('stg_order_types') }}
),

treated AS (
    SELECT DISTINCT
        id AS order_types_id
        ,CASE
            WHEN type = 'sales' THEN 'VENDAS'
            WHEN type = 'technical_review' THEN 'REVISÃO TÉCNICA'
            WHEN type = 'preventive_maintenance' THEN 'MANUTENÇÃO PREVENTIVA'
            WHEN type = 'body_shop' THEN 'LOJA'
            ELSE 'OUTROS'
        END AS type
        ,frequency
    FROM stg
)

SELECT
    *
FROM treated