with date_spine as (

{{ dbt_utils.date_spine(
    datepart="day",
    start_date="cast('2021-01-01' as date)",
    end_date="cast('2022-01-01' as date)"
   )
}}

),

stg_year_month AS (
    SELECT
          a.date_day
        , MONTHNAME(a.date_day) AS month
        , YEAR(a.date_day) AS year
    FROM date_spine AS a 
    )

SELECT * FROM stg_year_month

