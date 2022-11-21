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
        , SUBSTRING(_fivetran_synced, 1, 10) AS FECHA
        , SUBSTRING(_fivetran_synced, 12, 8) AS HORA
    FROM src_sql_server_products
    )

SELECT * FROM products_v1