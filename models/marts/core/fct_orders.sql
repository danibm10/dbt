WITH fct_orders1 AS (
    SELECT * 
    FROM {{ ref('int_orders') }}
    ),

  dim_year_month_day1 AS (
  SELECT * 
  FROM {{ ref('dim_year_month_day') }}
    ), 

   stg_promos AS (
  SELECT * 
  FROM {{ ref('stg_promos') }}
    ), 

fct_orders AS (
    SELECT
          a.order_id
        , a.user_id
        , b.year_month_day_id
        , a.address_id
        , {{ eliminar_nulos_bueno('c.promo_id') }} as promo_id
        , a.shipping_service
        , a.delivery_date
        , a.tracking_id
        , a.status
        , {{ eliminar_nulos_bueno('a.delivery_time') }} as delivery_time
        , {{ eliminar_nulos_bueno('a.estimated_delivery_days') }} as estimated_delivery_days
        , CASE
            when a.estimated_delivery_days>0 then 'Retrasado'
            when a.estimated_delivery_days=0 then 'A tiempo'
            when a.estimated_delivery_days<1 then 'Antes de lo esperado'
            end as orders_time

        , CAST({{ eliminar_nulos_bueno('c.discount_usd') }} as VARCHAR) as discount_usd
        , a.shipping_cost_usd
        , a.order_total_usd
        , a.sync_date
        , a.sync_time
        
    FROM fct_orders1 AS a LEFT JOIN dim_year_month_day1 AS b
    ON a.creation_date = b.year_month_day_id
    LEFT JOIN stg_promos AS c
    ON a.promo_id=c.promo_name
    ), 

dim_orders AS (
    SELECT
          a.order_id
        , a.user_id
        , a.year_month_day_id
        , a.address_id
        , a.promo_id
        , a.shipping_service
        , a.delivery_date
        , a.tracking_id
        , a.status
        , a.delivery_time
        , a.estimated_delivery_days
        , {{ eliminar_nulos_bueno('a.orders_time') }} as orders_time
        , a.discount_usd
        , a.shipping_cost_usd
        , a.order_total_usd
        , a.sync_date
        , a.sync_time
        
    FROM fct_orders as a
    )

SELECT * FROM dim_orders