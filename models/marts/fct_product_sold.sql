{{
  config(
    materialized='view'
  )
}}

WITH fct_orders AS (
    SELECT * 
    FROM {{ ref('stg_orders') }}
    ),   

fct_order_items AS (
    SELECT * 
    FROM {{ ref('base_sql_server_order_items') }}
    ),  

fct_product_sold AS (
    SELECT (
        {{ dbt_utils.surrogate_key(['a.client_id', 'b.product_id','a.address_id']) }}) as product_sold_id
        , a.client_id
        , b.product_id
        , a.address_id
        , a.order_id
        , b.quantity

    FROM fct_orders AS a LEFT JOIN fct_order_items AS b
    ON a.order_id=b.order_id
    
    )

SELECT * FROM fct_product_sold