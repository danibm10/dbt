WITH int_products AS (
    SELECT * 
    FROM {{ ref('int_products') }}
    ),  


product_cost AS (
    SELECT TOP 1
        a.product_name
        ,a.product_unit_cost_usd
       

    FROM int_products AS a 
    ORDER BY 
        a.product_unit_cost_usd DESC

)

SELECT * FROM product_cost