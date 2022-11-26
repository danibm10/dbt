{{
  config(
    materialized='view'
  )
}}

WITH stg_sql_server_promos AS (
    SELECT * 
    FROM {{ ref('stg_promos') }}
    ),

dim_promos AS (
    SELECT
          a.promo_id
        , a.discount
        , a.status
        , a.fecha_sincronizacion as sync_date
        , a.hora_sincronizacion as sync_time
    FROM stg_sql_server_promos AS a 
    )

SELECT * FROM dim_promos