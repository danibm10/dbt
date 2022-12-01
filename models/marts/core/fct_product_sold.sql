{{
  config(
    materialized='view'
  )
}}

WITH fct_orders AS (
    SELECT * 
    FROM {{ ref('int_orders') }}
    ),   

fct_order_items AS (
    SELECT * 
    FROM {{ ref('stg_order_items') }}
    ),  

dim_year_month_day1 AS (
SELECT * 
FROM {{ ref('dim_year_month_day') }}
    ), 

dim_clients_detail1 AS (
SELECT * 
FROM {{ ref('dim_users_detail') }}
    ), 

dim_products_detail1 AS (
SELECT * 
FROM {{ ref('dim_products_detail') }}
    ), 

dim_addresses AS (
SELECT * 
FROM {{ ref('dim_addresses') }}
    ), 

fct_product_sold AS (
    SELECT DISTINCT (
        {{ dbt_utils.surrogate_key(['d.user_detail_id', 'e.product_detail_id','a.address_id','c.year_month_day_id']) }}) as product_sold_id
        , d.user_detail_id
        , e.product_detail_id
        , a.address_id
        , a.order_id
        , c.year_month_day_id
        , b.quantity as sales_quantity
        , (b.quantity * e.price_usd) AS sales_usd

    FROM fct_orders AS a LEFT JOIN fct_order_items AS b
    ON a.order_id=b.order_id
    LEFT JOIN dim_year_month_day1 AS c
    ON
    a.fecha_convertida=c.year_month_day_id
    LEFT JOIN dim_clients_detail1 AS d
    ON
    a.user_id = d.user_id
    LEFT JOIN dim_products_detail1 AS e
    ON
    b.product_id=e.product_id
    
    )

SELECT * FROM fct_product_sold