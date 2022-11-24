{{
  config(
    materialized='view'
  )
}}

WITH stg_google_sheets_budget AS (
    SELECT * 
    FROM {{ ref('base_google_sheets_budget') }}
    ),
 
stg_sql_server_products AS (
    SELECT * 
    FROM {{ ref('stg_products') }}
    ),  
 

stg_budget AS (
    SELECT
          a._row AS budget_id
        , a.product_id
        , a.month
        , a.quantity AS expected_quantity_sold
        , (a.quantity * b.price) AS expected_income
        , (a.quantity * b.product_unit_cost) AS expected_cost
        , (a.quantity * b.price) - (a.quantity * b.product_unit_cost) AS expected_profit
        , a.fecha_sincronizacion
        , a.hora_sincronizacion
     
    FROM stg_google_sheets_budget AS a left join stg_sql_server_products AS b
    ON a.product_id=b.product_id
    )

SELECT * FROM stg_budget