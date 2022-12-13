with date_spine as (

{{ dbt_utils.date_spine(
    datepart="day",
    start_date="cast('2021-01-01' as date)",
    end_date="cast('2022-01-01' as date)"
   )
}}

),


dim_year_month AS (
    SELECT DISTINCT 
    
          CONCAT(MONTH(a.date_day),' ',YEAR(a.date_day)) AS year_month_id
        , MONTHNAME(a.date_day) AS month
        , CAST(YEAR(a.date_day) AS VARCHAR) AS year
        
        
    FROM date_spine AS a 
   
    )

SELECT * FROM dim_year_month

