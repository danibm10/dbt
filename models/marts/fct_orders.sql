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
        , a.address_id
        , a.promo_id
        , REPLACE(a.shipping_service, 'usps','ups') AS shipping_service
        , a.shipping_cost
        , a.fecha_creacion
        , a.fecha_entrega
        , a.tracking_id
        , a.status
        , a.tiempo_entrega
        , a.order_total
        , a.tiempo_prevision_entrega
        , a.fecha_sincronizacion
        , a.hora_sincronizacion
        
    FROM fct_orders1 AS a
   
    )

SELECT * FROM fct_orders