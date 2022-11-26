{{
  config(
    materialized='view'
  )
}}

WITH fct_orders1 AS (
    SELECT * 
    FROM {{ ref('stg_orders') }}
    ),

fct_orders AS (
    SELECT
          a.order_id
        , a.client_id
        , a.promo_id
        , REPLACE(a.shipping_service, 'usps','ups') AS shipping_service
        , a.shipping_cost as shipping_cost_usd
        , a.fecha_creacion as created_at
        , a.fecha_entrega as delivery_date
        , a.tracking_id
        , a.status
        , a.tiempo_entrega as delivery_time
        , a.order_total as order_total_usd
        , a.tiempo_prevision_entrega as expected_delivery_time
        , a.fecha_sincronizacion as sync_date
        , a.hora_sincronizacion as sync_time
        
    FROM fct_orders1 AS a
   
    )

SELECT * FROM fct_orders