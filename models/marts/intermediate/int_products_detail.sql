{{
  config(
    materialized='view'
  )
}}

WITH stg_sql_server_productd AS (
    SELECT * 
    FROM {{ ref('stg_products')}}
    ),

seed_product_unit_cost AS (
    SELECT * 
    FROM {{ ref('product_unit_cost')}}
    ),

stg_product_detail AS (
    SELECT DISTINCT (
        {{ dbt_utils.surrogate_key(['a.product_id', 'b.product_unit_cost','a.price_usd','a._fivetran_synced ']) }}) AS product_detail_id
        , a.product_id
        , b.product_unit_cost as product_unit_cost_usd
        , a.price_usd
        , a._fivetran_synced 
    FROM stg_sql_server_productd AS a LEFT JOIN seed_product_unit_cost AS b
    ON a.product_id=b.product_id
    )

SELECT * FROM stg_product_detail