{{
  config(
    materialized='view'
  )
}}

WITH stg_sql_server_orders AS (
    SELECT * 
    FROM {{ ref('base_sql_server_orders') }}
    ),

stg_orders AS (
    SELECT
          a.order_id
        , a.user_id as client_id
        , a.address_id
        , a.promo_id
        , a.shipping_service
        , a.shipping_cost
        , a.fecha_creacion
        , CONCAT(DAY(a.fecha_creacion),' ',MONTHNAME(a.fecha_creacion),' ',YEAR(a.fecha_creacion)) AS fecha_convertida
        , a.fecha_entrega
        , a.tracking_id
        , a.status
        , DATEDIFF(day,a.fecha_creacion,a.fecha_entrega) AS tiempo_entrega
        , a.order_total
        , DATEDIFF(day,a.fecha_llegada_estimada,a.fecha_entrega) AS tiempo_prevision_entrega
        , a.fecha_sincronizacion
        , a.hora_sincronizacion
        
    FROM stg_sql_server_orders AS a
   
    )

SELECT * FROM stg_orders