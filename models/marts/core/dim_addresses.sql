WITH stg_sql_server_addresses AS (
    SELECT * 
    FROM {{ ref('stg_addresses') }}
    ),

seed_zipcodes_city AS (
    SELECT * 
    FROM {{ ref('zipcodes_city')}}
    ),    

dim_addresses AS (
    SELECT
          a.address_id
        , a.address
        , a.zipcode
        , {{ eliminar_nulos('b.city','null') }} as city 
        , a.state
        , a.country
        , a.sync_date
        , a.sync_time
    FROM stg_sql_server_addresses AS a LEFT JOIN seed_zipcodes_city AS b
    ON a.zipcode=b.zipcode
    )

SELECT * FROM dim_addresses
