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
        , CAST(SUBSTRING(_fivetran_synced, 1, 10) AS DATE) AS FECHA_SINCRONIZACION
        , CAST(SUBSTRING(_fivetran_synced, 12, 8) AS TIME) AS HORA_SINCRONIZACION
    FROM src_sql_server_products
    )

SELECT * FROM products_v1