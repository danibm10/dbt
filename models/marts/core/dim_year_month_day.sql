{{
  config(
    materialized='view'
  )
}}


with date_spine as (

{{ dbt_utils.date_spine(
    datepart="day",
    start_date="cast('2021-01-01' as date)",
    end_date="cast('2022-01-01' as date)"
   )
}}

),

dim_year_month_day AS (
    SELECT 
          CONCAT(DAY(a.date_day),' ',MONTHNAME(a.date_day),' ',YEAR(a.date_day)) as year_month_day_id
        , DAY(a.date_day) AS day
        , DAYNAME(a.date_day) AS day_name
        , MONTHNAME(a.date_day) AS month
        , YEAR(a.date_day) AS year
        , WEEK(a.date_day) AS week
        , QUARTER(a.date_day) AS quarter

    FROM date_spine AS a 
    )

SELECT * FROM dim_year_month_day

