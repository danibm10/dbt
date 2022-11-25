{{
  config(
    materialized='view'
  )
}}

WITH stg_sql_server_productd AS (
    SELECT * 
    FROM {{ ref('stg_products')}}
    ),


stg_product_detail AS (
    SELECT (
        {{ dbt_utils.surrogate_key(['a.product_id', 'a.product_unit_cost','a.price']) }}) AS product_detail_id
        , a.product_id
        , a.product_unit_cost
        , a.price
        , a.gama_producto
        , a._fivetran_synced 
    FROM stg_sql_server_productd AS a
    )

SELECT * FROM stg_product_detail