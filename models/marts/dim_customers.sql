WITH intermediate AS (
    SELECT DISTINCT
        *
    FROM {{ ref('int_customers') }} 
),

treated AS (
    SELECT
        ROW_NUMBER() OVER (ORDER BY customer_id) AS sk_customer
        ,customer_id
        ,first_name
        ,last_name
        ,gender
        ,job_title
        ,country
        ,city
        ,is_recurring
        ,level
        ,registration_date
    FROM intermediate
)

SELECT
    *
FROM treated