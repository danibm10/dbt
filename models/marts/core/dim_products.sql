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
        , a.inventory
        , CONCAT(SUBSTRING(a._fivetran_synced, 1, 10),' - ',SUBSTRING(a._fivetran_synced, 12, 8)) as sync_date_time 

    FROM stg_sql_server_products AS a 
    )

SELECT * FROM dim_products