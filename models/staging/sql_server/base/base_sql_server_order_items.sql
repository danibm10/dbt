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
          a.order_id
        , a.product_id
        , a.quantity
        , SUBSTRING(_fivetran_synced, 1, 10) AS FECHA SINCRONIZACIÓN
        , SUBSTRING(_fivetran_synced, 12, 8) AS HORA SINCRONIZACIÓN
    FROM src_sql_server_order_items AS a
    )

SELECT * FROM order_items_v1