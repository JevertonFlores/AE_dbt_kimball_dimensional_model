WITH stg AS (
    SELECT
        *
    FROM {{ ref('stg_customers')}}
),

treated AS (
    SELECT
    id AS customer_id
    ,UPPER(first_name) AS first_name
    ,UPPER(last_name) last_name
    ,CASE
        WHEN gender = 'F' THEN 'FEMININO'
        WHEN gender = 'M' THEN 'MASCULINO'
        ELSE 'OUTROS'
    END AS gender
    ,UPPER(job_title) AS job_title
    ,UPPER(domain) AS domain
    ,UPPER(email) AS email
    ,country_code
    ,UPPER(country) AS country
    ,UPPER(city) AS city
    ,latitude
    ,longitude
    ,recurring_customer AS id_recurring
    ,UPPER(customer_level) AS levell
    ,registration_date
    FROM stg
)

SELECT
    *
FROM treated