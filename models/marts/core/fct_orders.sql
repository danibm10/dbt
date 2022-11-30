{{
  config(
    materialized='view'
  )
}}

WITH fct_orders1 AS (
    SELECT * 
    FROM {{ ref('stg_orders') }}
    ),

  dim_year_month_day1 AS (
  SELECT * 
  FROM {{ ref('dim_year_month_day') }}
    ), 

   dim_promos AS (
  SELECT * 
  FROM {{ ref('dim_promos') }}
    ), 

fct_orders AS (
    SELECT
          a.order_id
        , a.client_id
        , b.year_month_day_id
        , a.promo_id
        , c.discount as discount_usd
        , REPLACE(a.shipping_service, 'usps','ups') AS shipping_service
        , a.shipping_cost as shipping_cost_usd
        , a.fecha_entrega as delivery_date
        , a.tracking_id
        , a.status
        , a.tiempo_entrega as delivery_time
        , a.order_total as order_total_usd
        , a.tiempo_prevision_entrega as expected_delivery_time
        , CASE
            when a.tiempo_prevision_entrega>0 then 'Retrasado'
            when a.tiempo_prevision_entrega<1 then 'Antes de lo esperado'
            end as orders_time

        , a.fecha_sincronizacion as sync_date
        , a.hora_sincronizacion as sync_time
        
    FROM fct_orders1 AS a LEFT JOIN dim_year_month_day1 AS b
    ON a.fecha_convertida = b.year_month_day_id
    LEFT JOIN dim_promos AS c
    ON a.promo_id=c.promo_id
    )

SELECT * FROM fct_orders