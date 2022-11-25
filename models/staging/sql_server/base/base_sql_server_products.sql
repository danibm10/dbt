{{
  config(
    materialized='view'
  )
}}

WITH src_sql_server_products AS (
    SELECT * 
    FROM {{ source('src_sql_server', 'products') }}
    ),

products_v1 AS (
    SELECT
          product_id
        , price
        , name
        , inventory
        , _fivetran_synced
    FROM src_sql_server_products
    )

SELECT * FROM products_v1