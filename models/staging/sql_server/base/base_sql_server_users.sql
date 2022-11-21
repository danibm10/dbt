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
        , SUBSTRING(created_at, 1, 10) AS FECHA
        , SUBSTRING(created_at, 12, 8) AS HORA
        , phone_number
        , total_orders
        , first_name
        , email
        , SUBSTRING(_fivetran_synced, 1, 10) AS FECHA2
        , SUBSTRING(_fivetran_synced, 12, 8) AS HORA2
    FROM src_sql_server_users
    )

SELECT * FROM users_v1