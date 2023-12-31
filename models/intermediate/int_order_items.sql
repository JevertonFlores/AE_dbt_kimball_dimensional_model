WITH stg AS (
    SELECT
        *
    FROM {{ ref('stg_order_items') }}
),

defining_elements AS (
    SELECT
        id
        ,order_id
        ,order_type_id
        ,item
        ,ARRAY_LENGTH(STRING_TO_ARRAY(item, '@~|~@'), 1) AS num_elements
    FROM stg
),

treatment_array AS (
    SELECT
        id
        ,order_id
        ,order_type_id
        ,SPLIT_PART(UPPER(item), '@~|~@', 1) AS manufacturer
        ,SPLIT_PART(UPPER(item), '@~|~@', 2) AS model
        ,SPLIT_PART(item, '@~|~@', 3) AS year_manufacturer
        ,SPLIT_PART(UPPER(item), '@~|~@', 4) AS color
        ,SPLIT_PART(UPPER(item), '@~|~@', 5) AS status
        ,SPLIT_PART(item, '@~|~@', 6) AS price
    FROM defining_elements
    WHERE num_elements = 6
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
        ,CASE
            WHEN status = 'USED' THEN 'USADO'
            WHEN status = 'NEW' THEN 'NOVO'
            WHEN status = 'SEMI-NEW' THEN 'SEMI-NOVO'
            ELSE 'OUTROS'
        END AS status
        ,price::NUMERIC
    FROM treatment_array
)

SELECT
    *
FROM treated