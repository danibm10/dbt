{{
  config(
    materialized='view'
  )
}}

WITH stg_sql_server_promos AS (
    SELECT * 
    FROM {{ ref('base_sql_server_promos') }}
    ),

stg_promos AS (
    SELECT
          a.promo_id
        , a.discount
        , a.status
        , a.fecha_sincronizacion
        , a.hora_sincronizacion
    FROM stg_sql_server_promos AS a 
    )

SELECT * FROM stg_promos