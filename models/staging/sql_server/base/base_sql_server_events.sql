{{
  config(
    materialized='view'
  )
}}

WITH src_sql_server_events AS (
    SELECT * 
    FROM {{ source('src_sql_server', 'events') }}
    ),

events_v1 AS (
    SELECT
          event_id
        , page_url
        , event_type
        , user_id
        , product_id
        , session_id
        , SUBSTRING(created_at, 1, 10) AS FECHA
        , SUBSTRING(created_at, 12, 8) AS HORA
        , order_id
        , SUBSTRING(_fivetran_synced, 1, 10) AS FECHA2
        , SUBSTRING(_fivetran_synced, 12, 8) AS HORA2
    FROM src_sql_server_events
    )

SELECT * FROM events_v1