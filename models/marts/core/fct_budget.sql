{{
  config(
    materialized='view'
  )
}}

WITH dim_google_sheets_budget AS (
    SELECT * 
    FROM {{ ref('int_budget')}}
    ),

stg_products AS (
    SELECT * 
    FROM {{ ref('stg_products') }}
    ),


dim_year_month AS (
    SELECT * 
    FROM {{ ref('dim_year_month') }}
    ),  

fct_budget AS (
    SELECT DISTINCT
          a.budget_id
        , a.product_id
        , b.month_year_id
        , a.expected_quantity_sold
        , ROUND((a.expected_quantity_sold * c.price_usd),2) AS expected_income_usd
        , ROUND((a.expected_quantity_sold * a.product_unit_cost_usd),2) AS expected_cost_usd
        , ROUND((a.expected_quantity_sold * c.price_usd) - (a.expected_quantity_sold * a.product_unit_cost_usd),2) AS expected_profit_usd
        , a.sync_date
        , a.sync_time 
          
    FROM dim_google_sheets_budget AS a LEFT JOIN dim_year_month AS b
    ON a.date = b.month_year_id
    LEFT JOIN stg_products AS c
    ON a.product_id=c.product_id

    ORDER BY 
          a.budget_id
    )

SELECT * FROM fct_budget