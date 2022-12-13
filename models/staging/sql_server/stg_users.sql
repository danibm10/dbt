{{
  config(
    materialized='view'
  )
}}

WITH stg_sql_server_users AS (
    SELECT * 
    FROM {{ source('src_sql_server', 'users')}}
    ),


stg_users AS (
    SELECT 
          a.user_id
        , a.first_name
        , a.last_name
        , a.phone_number
        , a.email
        , a._fivetran_synced 
          
    FROM stg_sql_server_users AS a
    )

SELECT * FROM stg_users