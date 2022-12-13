WITH int_orders AS (
    SELECT * 
    FROM {{ ref('int_orders') }}
    ),   

stg_order_items AS (
    SELECT * 
    FROM {{ ref('stg_order_items') }}
    ),  

dim_year_month AS (
SELECT * 
FROM {{ ref('dim_year_month') }}
    ), 

dim_products_detail1 AS (
SELECT * 
FROM {{ ref('dim_products') }}
    ), 


fct_product_profit AS (
    SELECT (
        {{ dbt_utils.surrogate_key(['a.product_id', 'b.creation_date','a.quantity','c.price_usd * a.quantity']) }}) as product_profit_id
        , a.product_id
        , CONCAT(MONTH(b.creation_date),' ',YEAR(b.creation_date)) AS month_year_id_profit
        , a.quantity
        , (c.price_usd * a.quantity) as total_income
        , (c.product_unit_cost_usd * a.quantity) as total_cost
        , (c.price_usd * a.quantity) - (c.product_unit_cost_usd * a.quantity) as total_profit
        

    FROM stg_order_items AS a LEFT JOIN int_orders AS b
    ON a.order_id=b.order_id
    LEFT JOIN dim_products_detail1 AS c
    ON
    a.product_id=c.product_id
    
    
    ), 

fct_product_profit1 AS (
    SELECT
          a.product_profit_id
        , a.product_id
        , b.year_month_id
        , a.quantity as sales_quantity
        , a.total_income
        , a.total_cost
        , ROUND(a.total_profit,2) as total_profit

    FROM fct_product_profit AS a left join dim_year_month AS b
    ON a.month_year_id_profit=b.year_month_id

)



SELECT * FROM fct_product_profit1