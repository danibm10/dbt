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
        , CAST(SUBSTRING(created_at, 1, 10) AS DATE) AS created_at_day
        , CAST(SUBSTRING(created_at, 12, 8) AS TIME) AS created_at_time
        , order_id
        , CAST(SUBSTRING(_fivetran_synced, 1, 10) AS DATE) AS FECHA_SINCRONIZACION
        , CAST(SUBSTRING(_fivetran_synced, 12, 8) AS TIME) AS HORA_SINCRONIZACION
    FROM src_sql_server_events
    )

SELECT * FROM events_v1