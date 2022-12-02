{{
  config(
    materialized='view'
  )
}}

WITH stg_sql_server_promos AS (
    SELECT * 
    FROM {{ source('src_sql_server', 'promos') }}
    ),

stg_promos AS (
    SELECT
          a.promo_id
        , a.discount
        , a.status
        , CAST(SUBSTRING(_fivetran_synced, 1, 10) AS DATE) AS sync_date
        , CAST(SUBSTRING(_fivetran_synced, 12, 8) AS TIME) AS sync_time
    FROM stg_sql_server_promos AS a 
    )

SELECT * FROM stg_promos