{{
  config(
    materialized='view'
  )
}}

WITH dim_google_sheets_budget AS (
    SELECT * 
    FROM {{ ref('stg_budget')}}
    ),

dim_year_month_day1 AS (
    SELECT * 
    FROM {{ ref('dim_year_month') }}
    ),  

fct_budget AS (
    SELECT DISTINCT
          a.budget_id
        , a.product_id
        , b.month_year_id
        , a.expected_quantity_sold
        , ROUND(a.expected_income,2) as expected_income_usd
        , ROUND(a.expected_cost,2) as expected_cost_usd
        , ROUND(a.expected_profit,2) as expected_profit_usd
        , a.sync_date
        , a.sync_time 
          
    FROM dim_google_sheets_budget AS a LEFT JOIN dim_year_month_day1 AS b
    ON a.date = b.month_year_id

    ORDER BY 
          a.budget_id
    )

SELECT * FROM fct_budget