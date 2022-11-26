{{
  config(
    materialized='view'
  )
}}

WITH dim_sql_server_users AS (
    SELECT * 
    FROM {{ ref('stg_clients')}}
    ),


dim_clients AS (
    SELECT 
          a.client_id
        , a.first_name
        , a.last_name
        , CONCAT(SUBSTRING(a._fivetran_synced, 1, 10),' - ',SUBSTRING(a._fivetran_synced, 12, 8)) as sync_date_time 
          
    FROM dim_sql_server_users AS a
    )

SELECT * FROM dim_clients