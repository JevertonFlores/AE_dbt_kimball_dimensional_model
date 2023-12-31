WITH stg AS (
    SELECT
        *
    FROM {{ ref('stg_employees')}}
),

treated AS (
    SELECT
        id as employee_id
        ,company_branches_id
        ,departament_id
        ,CASE
            WHEN departament = 'technical manager' THEN 'GERENTE TÉCNICO'
            WHEN departament = 'sales manager' THEN 'GERENTE DE VENDAS'
            WHEN departament = 'sales coordinator' THEN 'COORDENADOR DE VENDAS'
            WHEN departament = 'mecanic' THEN 'MECÂNICO'
            WHEN departament = 'operations director' THEN 'DIRETOR DE OPERAÇÕES'
            WHEN departament = 'sales director' THEN 'DIRETOR DE VENDAS'
            WHEN departament = 'salesman' THEN 'VENDEDOR'
            WHEN departament = 'technical' THEN 'TÉCNICO'
            ELSE 'OUTRO'
        END AS departament
        ,UPPER(first_name) AS first_name
        ,UPPER(last_name) AS last_name
        ,CASE
            WHEN gender = 'F' THEN 'FEMININO'
            WHEN gender = 'M' THEN 'MASCULINO'
            ELSE 'OUTROS'
        END AS gender
        ,UPPER(email) AS email
    FROM stg
)

SELECT
    *
FROM treated