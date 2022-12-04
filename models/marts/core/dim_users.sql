{{
  config(
    materialized='view'
  )
}}

WITH dim_sql_server_users AS (
    SELECT * 
    FROM {{ ref('stg_users')}}
    ),


dim_users AS (
    SELECT 
          a.user_id
        , a.first_name
        , a.last_name
        , CAST(SUBSTRING(_fivetran_synced, 1, 10) AS DATE) AS sync_date
        , CAST(SUBSTRING(_fivetran_synced, 12, 8) AS TIME) AS sync_time
          
    FROM dim_sql_server_users AS a
    )

SELECT * FROM dim_users