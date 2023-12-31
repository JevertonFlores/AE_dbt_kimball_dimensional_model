WITH stg AS (
    SELECT
        *
    FROM {{ ref('stg_order_items') }}
),

treatment_sales_status AS (
    SELECT
        id
        ,order_id
        ,order_type_id
        ,SPLIT_PART(UPPER(item), '@~|~@', 1) AS manufacturer
        ,SPLIT_PART(UPPER(item), '@~|~@', 2) AS model
        ,SPLIT_PART(item, '@~|~@', 3) AS year_manufacturer
        ,SPLIT_PART(UPPER(item), '@~|~@', 4) AS color
        ,0 AS status_id
        ,SPLIT_PART(UPPER(item), '@~|~@', 5) AS status
        ,SPLIT_PART(item, '@~|~@', 6) AS price
    FROM stg
    WHERE order_type_id = 1
),

treatment_other_status AS (
    SELECT
        id
        ,order_id
        ,order_type_id
        ,(
            SELECT DISTINCT 
                manufacturer 
            FROM treatment_sales_status 
            WHERE treatment_sales_status.model = SPLIT_PART(UPPER(stg.item), '@~|~@', 1)
        ) AS manufacturer
        ,SPLIT_PART(UPPER(item), '@~|~@', 1) AS model
        ,NULL AS year_manufacturer
        ,NULL AS color
        ,SPLIT_PART(UPPER(item), '@~|~@', 2)::INTEGER AS status_id
        ,SPLIT_PART(UPPER(item), '@~|~@', 3) AS status
        ,SPLIT_PART(item, '@~|~@', 4) AS price
    FROM stg
    WHERE order_type_id <> 1
),

union_status AS (
    SELECT * FROM treatment_sales_status
    UNION ALL
    SELECT * FROM treatment_other_status
),

treated AS (
    SELECT DISTINCT
        id AS order_item_id
        ,order_id
        ,order_type_id
        ,manufacturer
        ,model
        ,year_manufacturer
        ,CASE
            WHEN color = 'RED' THEN 'VERMELHO'
            WHEN color = 'WHITE' THEN 'BRANCO'
            WHEN color = 'BLACK' THEN 'PRETO'
            WHEN color = 'BLUE' THEN 'AZUL'
            WHEN color = 'GREEN' THEN 'VERDE'
            WHEN color = 'SILVER' THEN 'PRATA'
            ELSE 'OUTROS'
        END AS color
        ,status_id
        ,CASE
            WHEN status = 'USED' THEN 'USADO'
            WHEN status = 'NEW' THEN 'NOVO'
            WHEN status = 'SEMI-NEW' THEN 'SEMI-NOVO'
            ELSE 'OUTROS'
        END AS status
        ,price::NUMERIC
    FROM union_status
)

SELECT
    *
FROM treated