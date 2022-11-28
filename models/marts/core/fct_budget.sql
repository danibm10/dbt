{{
  config(
    materialized='view'
  )
}}

WITH dim_google_sheets_budget AS (
    SELECT * 
    FROM {{ ref('stg_budget')}}
    ),


fct_budget AS (
    SELECT DISTINCT
          a.budget_id
        , a.product_id
        , CONCAT(a.month,' ',a.year) as date
        , a.expected_quantity_sold
        , ROUND(a.expected_income,2) as expected_income_usd
        , ROUND(a.expected_cost,2) as expected_cost_usd
        , ROUND(a.expected_profit,2) as expected_profit_usd
        , a.sync_date
        , a.sync_time 
          
    FROM dim_google_sheets_budget AS a

    ORDER BY 
          a.budget_id
    )

SELECT * FROM fct_budget