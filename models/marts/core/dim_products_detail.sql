WITH intermediate_product AS (
    SELECT * 
    FROM {{ ref('snap_dim_products_detail') }}
    ),

int_products_detail AS (
    SELECT * 
    FROM {{ ref('int_products_detail')}}
    ),

dim_products_detail AS (
    SELECT DISTINCT
          a.product_detail_id
        , a.product_id
        , a.product_unit_cost_usd
        , a.price_usd
        , CASE
            when a.price_usd<25 then 'Baja'
            when a.price_usd BETWEEN 25 AND 50 then 'Media'
            when a.price_usd>50 then 'Alta'
            end as gama_producto
            
        , CONCAT(SUBSTRING(b.dbt_valid_from, 1, 10),' - ',SUBSTRING(b.dbt_valid_from, 12, 8)) as valid_from
        , b.dbt_valid_to AS valid_to
        
    FROM int_products_detail AS a LEFT JOIN intermediate_product AS b
    ON a.product_detail_id=b.product_detail_id
   
    )

SELECT * FROM dim_products_detail