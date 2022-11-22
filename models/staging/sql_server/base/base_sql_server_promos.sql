{{
  config(
    materialized='view'
  )
}}

WITH src_sql_server_promos AS (
    SELECT * 
    FROM {{ source('src_sql_server', 'promos') }}
    ),

promos_v1 AS (
    SELECT
          promo_id
        , discount
        , status
        , CAST(SUBSTRING(_fivetran_synced, 1, 10) AS DATE) AS FECHA_SINCRONIZACION
        , CAST(SUBSTRING(_fivetran_synced, 12, 8) AS TIME) AS HORA_SINCRONIZACION
    FROM src_sql_server_promos
    )

SELECT * FROM promos_v1