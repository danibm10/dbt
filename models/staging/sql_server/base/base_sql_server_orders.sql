{{
  config(
    materialized='view'
  )
}}

WITH src_sql_server_orders AS (
    SELECT * 
    FROM {{ source('src_sql_server', 'orders') }}
    ),

orders_v1 AS (
    SELECT
          a.order_id
        , a.shipping_service
        , a.shipping_cost
        , a.address_id
        , SUBSTRING(a.created_at, 1, 10) AS FECHA
        , SUBSTRING(a.created_at, 12, 8) AS HORA
        , a.promo_id
        , SUBSTRING(a.estimated_delivery_at, 1, 10) AS FECHA2
        , SUBSTRING(a.estimated_delivery_at, 12, 8) AS HORA2
        , a.order_cost
        , a.user_id
        , a.order_total
        , SUBSTRING(a.delivered_at, 1, 10) AS FECHA3
        , SUBSTRING(a.delivered_at, 12, 8) AS HORA3
        , a.tracking_id
        , a.status
        , SUBSTRING(a._fivetran_synced, 1, 10) AS FECHA4
        , SUBSTRING(a._fivetran_synced, 12, 8) AS HORA4
    FROM src_sql_server_orders AS a
    )

SELECT * FROM orders_v1