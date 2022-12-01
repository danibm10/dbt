WITH dim_addresses AS (
    SELECT * 
    FROM {{ ref('int_addresses') }}
    ),


dim_addresses AS (
    SELECT
          a.address_id
        , a.address
        , a.zipcode
        , a.city 
        , a.state
        , a.country
        , a.sync_date
        , a.sync_time

    FROM dim_addresses AS a 
    )

SELECT * FROM dim_addresses