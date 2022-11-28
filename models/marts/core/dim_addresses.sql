{{
  config(
    materialized='view'
  )
}}

WITH dim_addresses AS (
    SELECT * 
    FROM {{ ref('stg_addresses') }}
    ),


dim_addresses AS (
    SELECT
          a.address_id
        , a.address
        , a.zipcode
        , a.city 
        , a.state
        , a.country
        , a.fecha_sincronizacion AS sync_date
        , a.hora_sincronizacion AS sync_time

    FROM dim_addresses AS a 
    )

SELECT * FROM dim_addresses