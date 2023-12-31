WITH stg AS (
    SELECT
        *
    FROM {{ ref('stg_orders') }}
),

treated AS (
    SELECT DISTINCT
        id::INTEGER AS order_status_id
        ,CASE 
            WHEN order_status = 'on hold' THEN 'EM ESPERA'
            WHEN order_status = 'shipped' THEN 'ENVIADO'
            WHEN order_status = 'pending' THEN 'PENDENTE'
            WHEN order_status = 'delayed' THEN 'ATRASADO'
            ELSE 'OUTROS'
        END AS order_status
        ,TO_TIMESTAMP(order_date, 'YYYY-MM-DD HH24:MI:SS') AS order_date
        ,TO_TIMESTAMP(return_date, 'YYYY-MM-DD HH24:MI:SS') AS return_date
    FROM stg
)

SELECT
    *
FROM treated