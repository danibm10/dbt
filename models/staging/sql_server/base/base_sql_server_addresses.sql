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
        , SUBSTRING(_fivetran_synced, 1, 10) AS FECHA
        , SUBSTRING(_fivetran_synced, 12, 8) AS HORA
    FROM src_sql_server_addresses
    )

SELECT * FROM addresses_v1