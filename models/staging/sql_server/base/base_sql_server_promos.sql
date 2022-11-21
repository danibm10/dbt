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
        , SUBSTRING(_fivetran_synced, 1, 10) AS FECHA
        , SUBSTRING(_fivetran_synced, 12, 8) AS HORA
    FROM src_sql_server_promos
    )

SELECT * FROM promos_v1