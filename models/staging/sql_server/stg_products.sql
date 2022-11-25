{{
  config(
    materialized='view'
  )
}}

WITH stg_sql_server_products AS (
    SELECT * 
    FROM {{ ref('base_sql_server_products') }}
    ),

seed_product_unit_cost AS (
    SELECT * 
    FROM {{ ref('product_unit_cost')}}
    ),

stg_sql_server_order_items AS (
    SELECT * 
    FROM {{ ref('base_sql_server_order_items') }}
    ),    

stg_products AS (
    SELECT
          a.product_id
        , a.name
        , a.inventory
        , b.product_unit_cost 
        , a.price
        , CASE
            when a.price<25 then 'Baja'
            when a.price BETWEEN 25 AND 50 then 'Media'
            when a.price>50 then 'Alta'
            end as gama_producto
        , c.quantity AS quantity_sold
        , a._fivetran_synced
    FROM stg_sql_server_products AS a LEFT JOIN seed_product_unit_cost AS b
    ON a.product_id=b.product_id
    RIGHT JOIN stg_sql_server_order_items AS c
    ON a.product_id=c.product_id
    )

SELECT * FROM stg_products