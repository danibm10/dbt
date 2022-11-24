{{
  config(
    materialized='view'
  )
}}

WITH stg_sql_server_events AS (
    SELECT * 
    FROM {{ ref('base_sql_server_events')}}
    ),


stg_events AS (
    SELECT
          a.event_id as id_event
        , a.product_id as id_product
        , a.order_id as id_order
        , a.session_id as id_session
        , a.page_url
        , a.event_type
        , a.fecha_creacion
        , a.session_id
          
    FROM stg_sql_server_events AS a
    )

SELECT * FROM stg_events