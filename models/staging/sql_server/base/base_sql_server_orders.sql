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
        , CAST(SUBSTRING(a.created_at, 1, 10) AS DATE) AS FECHA_CREACION
        , CAST(SUBSTRING(a.created_at, 12, 8) AS TIME) AS HORA_CREACION
        , a.promo_id
        , CAST(SUBSTRING(a.estimated_delivery_at, 1, 10) AS DATE) AS FECHA_LLEGADA_ESTIMADA
        , CAST(SUBSTRING(a.estimated_delivery_at, 12, 8) AS TIME) AS HORA_LLEGADA_ESTIMADA
        , a.order_cost
        , a.user_id
        , a.order_total
        , CAST(SUBSTRING(a.delivered_at, 1, 10) AS DATE) AS FECHA_ENTREGA
        , CAST(SUBSTRING(a.delivered_at, 12, 8) AS TIME) AS HORA_ENTREGA
        , a.tracking_id
        , a.status
        , CAST(SUBSTRING(_fivetran_synced, 1, 10) AS DATE) AS FECHA_SINCRONIZACION
        , CAST(SUBSTRING(_fivetran_synced, 12, 8) AS TIME) AS HORA_SINCRONIZACION
    FROM src_sql_server_orders AS a
    )

SELECT * FROM orders_v1