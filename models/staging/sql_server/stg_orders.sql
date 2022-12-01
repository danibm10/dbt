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
        , a.shipping_cost as shipping_cost_usd
        , a.address_id
        , CAST(SUBSTRING(a.created_at, 1, 10) AS DATE) AS creation_date
        , CAST(SUBSTRING(a.created_at, 12, 8) AS TIME) AS creation_time
        , a.promo_id
        , CAST(SUBSTRING(a.estimated_delivery_at, 1, 10) AS DATE) AS estimated_delivery_date
        , CAST(SUBSTRING(a.estimated_delivery_at, 12, 8) AS TIME) AS estimated_delivery_time
        , a.order_cost
        , a.user_id
        , a.order_total as order_total_usd
        , CAST(SUBSTRING(a.delivered_at, 1, 10) AS DATE) AS delivery_date
        , CAST(SUBSTRING(a.delivered_at, 12, 8) AS TIME) AS delivery_time
        , a.tracking_id
        , a.status
        , CAST(SUBSTRING(_fivetran_synced, 1, 10) AS DATE) AS sync_date
        , CAST(SUBSTRING(_fivetran_synced, 12, 8) AS TIME) AS sync_time
    FROM src_sql_server_orders AS a
    )

SELECT * FROM orders_v1