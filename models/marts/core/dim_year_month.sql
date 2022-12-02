{{
  config(
    materialized='view'
  )
}}

WITH dim_year_month1 AS (
    SELECT * 
    FROM {{ ref('int_year_month') }}
    ),

dim_year_month AS (
    SELECT DISTINCT 
    
          CONCAT(a.month,' ',a.year) AS month_year_id
        , a.month
        , a.year
        
        
    FROM dim_year_month1 AS a
   
    )

SELECT * FROM dim_year_month