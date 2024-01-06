WITH intermediate_orders AS (
    SELECT 
        order_id
        ,order_item_id
        ,company_branches_id
        ,employee_id
        ,order_type_id
        ,customer_id
        ,order_date
        ,return_date
        ,days_diff
        ,hours_diff
    FROM {{ ref('int_orders') }}
),

order_status AS (
    SELECT
        dos.sk_order_status
        ,dos.order_status
        ,os.order_status_id
    FROM {{ ref('dim_order_status') }} dos
    LEFT JOIN {{ ref('int_order_status') }} os
        ON dos.order_status = os.order_status
),

product AS (
    SELECT
        prd.sk_product
        ,oi.order_item_id
        ,prd.product
    FROM {{ ref('dim_products') }} prd
    LEFT JOIN {{ ref('int_order_items') }} oi
        ON prd.product = oi.status
),

sales_datails AS (
    SELECT
        sd.sk_sales_details
        ,oi.order_item_id
        ,sd.year_manufacturer
        ,sd.color
        ,sd.status
    FROM {{ ref('dim_sales_details') }} sd 
    LEFT JOIN {{ ref('int_order_items') }} oi
        ON sd.year_manufacturer = oi.year_manufacturer
        AND sd.color = oi.color
        AND sd.status = oi.status
),

services AS (
    SELECT
        srv.sk_service
        ,oi.order_item_id
        ,srv.service
    FROM {{ ref('dim_services') }} srv
    LEFT JOIN {{ ref('int_order_items') }} oi
        ON srv.service = oi.status
),

vehicles AS (
    SELECT
        v.sk_vehicle
        ,oi.order_item_id
        ,v.manufacturer
        ,v.model
    FROM {{ ref('dim_vehicles') }} v
    LEFT JOIN {{ ref('int_order_items') }} oi
        ON v.manufacturer = oi.manufacturer
        AND v.model = oi.model
),

final_orders AS (
    SELECT
        io.order_id
        ,cb.sk_company_branch
        ,e.sk_employee
        ,ot.sk_order_type
        ,c.sk_customer
        ,os.sk_order_status
        ,prd.sk_product
        ,sd.sk_sales_details
        ,srv.sk_service
        ,veh.sk_vehicle
        ,io.order_date
        ,io.return_date
        ,io.days_diff
        ,io.hours_diff
    FROM intermediate_orders io
    LEFT JOIN {{ ref('dim_company_branches') }} cb
        ON io.company_branches_id = cb.company_branch_id
    LEFT JOIN {{ ref('dim_employees') }} e 
        ON io.employee_id = e.employee_id
    LEFT JOIN {{ ref('dim_order_types') }} ot 
        ON io.order_type_id = ot.order_type_id
    LEFT JOIN {{ ref('dim_customers') }} c 
        ON io.customer_id = c.customer_id
    LEFT JOIN order_status os
        ON io.order_id = os.order_status_id
    LEFT JOIN product prd
        ON io.order_item_id = prd.order_item_id
    LEFT JOIN sales_datails sd 
        ON io.order_item_id = sd.order_item_id
    LEFT JOIN services srv
        ON io.order_item_id = srv.order_item_id
    LEFT JOIN vehicles veh
        ON io.order_item_id = veh.order_item_id
)

SELECT
    *
FROM final_orders

-- ADICIONAR O PRICE