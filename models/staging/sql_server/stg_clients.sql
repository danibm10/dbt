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
          a.user_id AS client_id
        , a.first_name
        , a.last_name
        , a._fivetran_synced 
          
    FROM stg_sql_server_users AS a
    )

SELECT * FROM stg_clients