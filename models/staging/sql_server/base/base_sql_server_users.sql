{{
  config(
    materialized='view'
  )
}}

WITH src_sql_server_users AS (
    SELECT * 
    FROM {{ source('src_sql_server', 'users') }}
    ),

users_v1 AS (
    SELECT
          user_id
        , updated_at
        , address_id
        , last_name
        , CAST(SUBSTRING(created_at, 1, 10) AS DATE) AS FECHA_CREACION
        , CAST(SUBSTRING(created_at, 12, 8) AS TIME) AS HORA_CREACION
        , phone_number
        , total_orders
        , first_name
        , email
        , _fivetran_synced
        
    FROM src_sql_server_users
    )

SELECT * FROM users_v1