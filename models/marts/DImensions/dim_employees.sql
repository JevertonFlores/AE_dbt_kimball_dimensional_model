WITH intermediate AS (
    SELECT DISTINCT
        *
    FROM {{ ref('int_employees') }}
),

treated AS (
    SELECT
        ROW_NUMBER() OVER (ORDER BY employee_id) AS sk_employee
        ,employee_id
        ,first_name
        ,last_name
        ,departament AS role
        ,gender
        ,email
    FROM intermediate
)

SELECT
    *
FROM treated