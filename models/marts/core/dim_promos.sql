WITH stg_promos AS (
    SELECT * 
    FROM {{ ref('stg_promos') }}
    ),

dim_promos AS (
    SELECT
          a.promo_id
        , a.promo_name
        , a.discount_usd
        , a.status
        , a.sync_date
        , a.sync_time
    FROM stg_promos AS a 
    )

SELECT * FROM dim_promos
