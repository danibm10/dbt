{{
  config(
    materialized='view'
  )
}}

WITH stg_sql_server_users AS (
    SELECT * 
    FROM {{ ref('base_sql_server_users')}}
    ),


stg_client_detail AS (
    SELECT (
        {{ dbt_utils.surrogate_key(['a.user_id', 'a.phone_number','a.email']) }}) AS client_detail_id
        , a.user_id AS client_id
        , a.phone_number
        , a.email
        , a._fivetran_synced 
    FROM stg_sql_server_users AS a
    )

SELECT * FROM stg_client_detail