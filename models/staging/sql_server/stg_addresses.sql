{{
  config(
    materialized='view'
  )
}}

WITH src_sql_server_addresses AS (
    SELECT * 
    FROM {{ source('src_sql_server', 'addresses') }}
    ),

addresses_v1 AS (
    SELECT
          address_id
        , zipcode
        , country
        , address
        , state
        , CAST(SUBSTRING(_fivetran_synced, 1, 10) AS DATE) AS sync_date
        , CAST(SUBSTRING(_fivetran_synced, 12, 8) AS TIME) AS sync_time
    FROM src_sql_server_addresses
    )

SELECT * FROM addresses_v1