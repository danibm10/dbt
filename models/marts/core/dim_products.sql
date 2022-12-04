{{
  config(
    materialized='view'
  )
}}

WITH stg_sql_server_products AS (
    SELECT * 
    FROM {{ ref('stg_products') }}
    ),
   

dim_products AS (
    SELECT
          a.product_id
        , a.name
        , a.inventory as security_stock
        , CAST(SUBSTRING(_fivetran_synced, 1, 10) AS DATE) AS sync_date
        , CAST(SUBSTRING(_fivetran_synced, 12, 8) AS TIME) AS sync_time

    FROM stg_sql_server_products AS a 
    )

SELECT * FROM dim_products