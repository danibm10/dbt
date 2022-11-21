{{
  config(
    materialized='view'
  )
}}

WITH src_sql_server_order_items AS (
    SELECT * 
    FROM {{ source('src_sql_server', 'order_items') }}
    ),

order_items_v1 AS (
    SELECT
          order_id
        , product_id
        , quantity
        , SUBSTRING(_fivetran_synced, 1, 10) AS FECHA
        , SUBSTRING(_fivetran_synced, 12, 8) AS HORA
    FROM src_sql_server_order_items
    )

SELECT * FROM order_items_v1