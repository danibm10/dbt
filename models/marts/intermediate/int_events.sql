{{
  config(
    materialized='view'
  )
}}

WITH stg_sql_server_events AS (
    SELECT * 
    FROM {{ ref('stg_events')}}
    ),


int_events AS (
    SELECT
          a.event_id
        , a.user_id
        , a.product_id
        , a.order_id
        , a.session_id
        , a.page_url
        , a.event_type
        , a.created_at_time
        , CASE
            when HOUR(a.created_at_time) between 6 and 14 then 'mañana'
            when HOUR(a.created_at_time) between 14 and 20 then 'tarde'
            when HOUR(a.created_at_time) between 20 and 23 then 'noche'
            else 'madrugada'
            end as momento_del_dia

        , a.created_at_day
        , a.sync_date
        , a.sync_time
          
    FROM stg_sql_server_events AS a
    )

SELECT * FROM int_events