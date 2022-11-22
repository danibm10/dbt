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
        , CAST(SUBSTRING(_fivetran_synced, 1, 10) AS DATE) AS FECHA_SINCRONIZACION
        , CAST(SUBSTRING(_fivetran_synced, 12, 8) AS TIME) AS HORA_SINCRONIZACION
    FROM src_sql_server_order_items
    )

SELECT * FROM order_items_v1