WITH dim_year_month AS (
    SELECT * 
    FROM {{ ref('dim_year_month') }}
    ),  

fct_budget AS (
    SELECT * 
    FROM {{ ref('fct_budget')}}
    ),  

fct_product_profit AS (
    SELECT * 
    FROM {{ ref('fct_product_profit')}}
    ),  

fct_product_profit1 AS (
    SELECT
          
          a.year_month_id
        , SUM(a.total_profit) as total_profit
        
    FROM fct_product_profit AS a
    group by
          a.year_month_id

),


beneficio AS (
    SELECT
          
          b.year_month_id
        , SUM(c.expected_profit_usd) as expected_profit
        , a.total_profit
        , ROUND((a.total_profit) - (SUM(c.expected_profit_usd)),2) as desviacion_beneficio
        
    FROM fct_product_profit1 AS a left join dim_year_month as b
    on a.year_month_id=b.year_month_id
    left join fct_budget as c
    on a.year_month_id=c.year_month_id
    where a.year_month_id = '2 2021'
    group by
          b.year_month_id
        , a.total_profit
        
)

SELECT * FROM beneficio