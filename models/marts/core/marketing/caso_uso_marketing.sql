WITH fct_product_sold AS (
    SELECT * 
    FROM {{ ref('fct_product_sold') }}
    ),  

dim_products AS (
    SELECT * 
    FROM {{ ref('dim_products')}}
    ),  

fct_product_sold1 AS (
    SELECT top 1
          
          b.product_name
        , SUM(a.sales_quantity) AS sales_quantity

    FROM fct_product_sold AS a left join dim_products as b
    on a.product_detail_id=b.product_detail_id
    WHERE a.momento_del_dia= 'tarde'
    GROUP BY b.product_name
    ORDER BY SUM(a.sales_quantity) asc

)

SELECT * FROM fct_product_sold1