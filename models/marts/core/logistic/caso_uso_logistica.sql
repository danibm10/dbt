WITH fct_orders AS (
    SELECT * 
    FROM {{ ref('fct_orders') }}
    ),

dim_orders AS (
    SELECT
         
          a.orders_time
        , COUNT(a.orders_time) as recuento_pedidos
        
    FROM fct_orders as a
    WHERE a.orders_time<> 'Unknown'
    GROUP BY a.orders_time
    )

SELECT * FROM dim_orders