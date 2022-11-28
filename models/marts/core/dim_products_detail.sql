{{
  config(
    materialized='view'
  )
}}

WITH intermediate_product AS (
    SELECT * 
    FROM {{ ref('snap_dim_product_detail') }}
    ),

dim_products_detail AS (
    SELECT DISTINCT
          a.product_detail_id
        , a.product_id
        , a.product_unit_cost as product_unit_cost_usd
        , a.price as price_usd
        , a.gama_producto
        , CONCAT(SUBSTRING(a.dbt_valid_from, 1, 10),' - ',SUBSTRING(a.dbt_valid_from, 12, 8)) as valid_from
        , a.dbt_valid_to AS valid_to
        
    FROM intermediate_product AS a
   
    )

SELECT * FROM dim_products_detail