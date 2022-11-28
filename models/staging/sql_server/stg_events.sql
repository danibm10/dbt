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
          a.event_id
        , a.user_id AS client_id
        , a.product_id
        , a.order_id
        , a.session_id
        , a.page_url
        , a.event_type
        , CONCAT(DAY(a.fecha_creacion),' ',MONTHNAME(a.fecha_creacion),' ',YEAR(a.fecha_creacion)) AS created_at
          
    FROM stg_sql_server_events AS a
    )

SELECT * FROM stg_events