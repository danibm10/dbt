WITH fct_orders AS (
    SELECT * 
    FROM {{ ref('fct_orders') }}
    ),

  
comercial AS (
    SELECT
          
         ROUND(((SUM(a.discount_usd)) / (SUM(a.order_total_usd)) *100),2) as descuento_ventas
        
    FROM fct_orders as a
    WHERE a.discount_usd<> 'Unknown'
    
    )

SELECT * FROM comercial