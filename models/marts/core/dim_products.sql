WITH intermediate_product AS (
    SELECT * 
    FROM {{ ref('snap_int_products') }}
    ),

int_products AS (
    SELECT * 
    FROM {{ ref('int_products') }}
    ),
   

dim_products AS (
    SELECT
          a.product_detail_id
        , a.product_id
        , a.product_name
        , a.product_unit_cost_usd
        , a.price_usd

        , CASE
            when a.price_usd<25 then 'Baja'
            when a.price_usd BETWEEN 25 AND 50 then 'Media'
            when a.price_usd>50 then 'Alta'
            end as gama_producto

        , CONCAT(SUBSTRING(b.dbt_valid_from, 1, 10),' - ',SUBSTRING(b.dbt_valid_from, 12, 8)) as valid_from
        , b.dbt_valid_to AS valid_to
        , CAST(SUBSTRING(a._fivetran_synced, 1, 10) AS DATE) AS sync_date
        , CAST(SUBSTRING(a._fivetran_synced, 12, 8) AS TIME) AS sync_time

    FROM int_products AS a LEFT JOIN intermediate_product AS b
    ON a.product_detail_id=b.product_detail_id
    )

SELECT * FROM dim_products