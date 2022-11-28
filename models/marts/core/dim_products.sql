{{
  config(
    materialized='view'
  )
}}

WITH dim_sql_server_products AS (
    SELECT * 
    FROM {{ ref('stg_products')}}
    ),


dim_products AS (
    SELECT DISTINCT
          a.product_id
        , a.name as product_name
        , a.inventory
        , CONCAT(SUBSTRING(a._fivetran_synced, 1, 10),' - ',SUBSTRING(a._fivetran_synced, 12, 8)) as sync_date_time 
          
    FROM dim_sql_server_products AS a
    )

SELECT * FROM dim_products