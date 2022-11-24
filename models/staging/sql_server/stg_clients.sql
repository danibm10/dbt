{{
  config(
    materialized='view'
  )
}}

WITH stg_sql_server_users AS (
    SELECT * 
    FROM {{ ref('base_sql_server_users')}}
    ),


stg_clients AS (
    SELECT
          a.user_id AS id_client
        , a.first_name
        , a.last_name
        , a.phone_number
        , a.email
        , a.fecha_sincronizacion
        , a.hora_sincronizacion
          
    FROM stg_sql_server_users AS a
    )

SELECT * FROM stg_clients