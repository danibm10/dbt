{{
  config(
    materialized='view'
  )
}}

WITH fct_events1 AS (
    SELECT * 
    FROM {{ ref('stg_events')}}
    ),


fct_events AS (
    SELECT
          a.event_id
        , a.client_id
        , a.product_id
        , b.year_month_day_id
        , a.order_id
        , a.session_id
        , a.page_url
        , a.event_type
        , CASE
            when a.order_id = '' then 'No Compra'
            else 'Compra'
            end as purchase_indicator
          
    FROM fct_events1 AS a LEFT JOIN dim_year_month_day AS b
    ON a.created_at = b.year_month_day_id
    )

SELECT * FROM fct_events