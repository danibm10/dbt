WITH fct_product_profit AS (
    SELECT * 
    FROM {{ ref('fct_product_profit') }}
    ),  

dim_products AS (
    SELECT * 
    FROM {{ ref('dim_products') }}
    ),

fct_product_profit1 AS (
    SELECT TOP 1
        b.product_name
        , SUM(a.total_profit) as total_profit

    FROM fct_product_profit AS a left join dim_products as b
    ON a.product_id=b.product_id

    GROUP BY
        b.product_name

    ORDER BY
        SUM(a.total_profit) DESC
)

SELECT * FROM fct_product_profit1