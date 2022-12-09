{{
  config(
    materialized='view'
  )
}}

WITH stg_sql_server_orders AS (
    SELECT * 
    FROM {{ ref('stg_orders') }}
    ),

stg_orders AS (
    SELECT
          a.order_id
        , a.user_id
        , a.address_id
        , a.promo_id
        , REPLACE(a.shipping_service, 'usps','ups') AS shipping_service
        , a.shipping_cost_usd
        , a.creation_date
        , a.creation_time
        , a.estimated_delivery_date
        , a.delivery_date
        , a.delivery_time
        , a.tracking_id
        , a.status
        , DATEDIFF(day,a.creation_date,a.delivery_date) AS delivery_days
        , a.order_total_usd
        , DATEDIFF(day,a.estimated_delivery_date,a.delivery_date) AS estimated_delivery_days
        , a.sync_date
        , a.sync_time
        
    FROM stg_sql_server_orders AS a
   
    )

SELECT * FROM stg_orders