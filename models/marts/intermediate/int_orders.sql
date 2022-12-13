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
        , {{ eliminar_nulos_bueno('a.estimated_delivery_date') }} as estimated_delivery_date 
        , {{ eliminar_nulos_bueno('a.delivery_date') }} as delivery_date
        , {{ eliminar_nulos_bueno('a.delivery_time') }} as delivery_time
        , a.tracking_id
        , a.status
        , CAST(DATEDIFF(day,a.creation_date,a.delivery_date) AS VARCHAR) AS delivery_days
        , a.order_total_usd
        , CAST(DATEDIFF(day,a.estimated_delivery_date,a.delivery_date) AS VARCHAR) AS estimated_delivery_days
        , a.sync_date
        , a.sync_time
        
    FROM stg_sql_server_orders AS a
   
    )

SELECT * FROM stg_orders