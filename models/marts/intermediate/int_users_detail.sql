{{
  config(
    materialized='view'
  )
}}

WITH stg_sql_server_users AS (
    SELECT * 
    FROM {{ ref('stg_users')}}
    ),


int_users AS (
    SELECT (
        {{ dbt_utils.surrogate_key(['a.user_id', 'a.phone_number','a.email']) }}) AS user_detail_id
        , a.user_id
        , a.phone_number
        , a.email
        , a._fivetran_synced 
    FROM stg_sql_server_users AS a
    )

SELECT * FROM int_users