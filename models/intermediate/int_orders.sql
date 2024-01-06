WITH stg AS (
    SELECT
        *
    FROM {{ ref('stg_orders') }}
),

treatment_types AS (
    SELECT
        id::INTEGER AS order_id
        ,employee_id
        ,order_type_id
        ,customer_id
        ,TO_TIMESTAMP(order_date, 'YYYY-MM-DD HH24:MI:SS') AS order_date
        ,TO_TIMESTAMP(return_date, 'YYYY-MM-DD HH24:MI:SS') AS return_date
    FROM stg
    WHERE customer_id <> 'id'
    -- Foram encontrados dois registros com customer_id mal formatados como string 'id' que estão sendo removidos.
),

treated AS (
    SELECT
        tt.order_id
        ,oi.order_item_id
        ,tt.employee_id
        ,ep.company_branches_id
        ,tt.order_type_id
        ,tt.customer_id::INTEGER AS customer_id
        ,tt.order_date
        ,tt.return_date
        ,(tt.return_date::DATE - tt.order_date::DATE) AS days_diff
        ,ROUND(EXTRACT(EPOCH FROM tt.return_date - tt.order_date) / 3600) AS hours_diff
    FROM treatment_types tt
    LEFT JOIN {{ ref('int_employees') }} ep
        ON tt.employee_id = ep.employee_id
    LEFT JOIN {{ ref('int_order_items') }} oi
        ON tt.order_id = oi.order_id
    WHERE oi.order_item_id IS NOT NULL
    -- Foram removidos os registros onde os itens não possuem ordem de vendas.
)

SELECT
    *
FROM treated