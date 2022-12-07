WITH fct_orders AS (
    SELECT * 
    FROM {{ ref('int_orders') }}
    ),   

fct_order_items AS (
    SELECT * 
    FROM {{ ref('stg_order_items') }}
    ),  

dim_year_month_day AS (
SELECT * 
FROM {{ ref('dim_year_month_day') }}
    ), 

dim_users AS (
SELECT * 
FROM {{ ref('dim_users') }}
    ), 

dim_products AS (
SELECT * 
FROM {{ ref('dim_products') }}
    ), 


fct_product_sold AS (
    SELECT DISTINCT (
        {{ dbt_utils.surrogate_key(['d.user_id', 'e.product_detail_id','a.address_id','c.year_month_day_id']) }}) as product_sold_id
        , d.user_id
        , e.product_detail_id
        , a.address_id
        , a.order_id
        , c.year_month_day_id
        , b.quantity as sales_quantity
        , (b.quantity * e.price_usd) AS sales_usd

    FROM fct_orders AS a LEFT JOIN fct_order_items AS b
    ON a.order_id=b.order_id
    LEFT JOIN dim_year_month_day AS c
    ON
    a.creation_date=c.year_month_day_id
    LEFT JOIN dim_users AS d
    ON
    a.user_id = d.user_id
    LEFT JOIN dim_products AS e
    ON
    b.product_id=e.product_id
    
    )

SELECT * FROM fct_product_sold