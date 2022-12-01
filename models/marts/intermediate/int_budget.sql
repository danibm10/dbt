{{
  config(
    materialized='view'
  )
}}

WITH stg_google_sheets_budget AS (
    SELECT * 
    FROM {{ ref('stg_budget') }}
    ),

product_unit_cost AS (
    SELECT * 
    FROM {{ ref('product_unit_cost')}}
    ),   
 
 

stg_budget AS (
    SELECT
          a._row AS budget_id
        , a.product_id
        , CONCAT(MONTHNAME(a.date),' ',YEAR(a.date)) as date
        , a.quantity AS expected_quantity_sold
        , c.product_unit_cost as product_unit_cost_usd
        , a.sync_date
        , a.sync_time
     
    FROM stg_google_sheets_budget AS a left join product_unit_cost AS c
    ON a.product_id=c.product_id
    )

SELECT * FROM stg_budget