WITH source AS (
    SELECT
        *
    FROM {{ source('seeds', 'customers') }}
)

SELECT
    id
    ,first_name
    ,last_name
    ,gender
    ,job_title
    ,domain
    ,email
    ,country_code
    ,country
    ,city
    ,latitude
    ,longitude
    ,recurring_customer
    ,customer_level
    ,registration_date
FROM source