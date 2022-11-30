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
        , MONTHNAME(a.date_day) AS month
        , YEAR(a.date_day) AS year
        , DAYNAME(a.date_day) AS day_name
        , WEEK(a.date_day) AS week
        , QUARTER(a.date_day) AS quarter
        , CASE
            when MONTHNAME(a.date_day) = 'Jan' then '1'
            when MONTHNAME(a.date_day) = 'Feb' then '1'
            when MONTHNAME(a.date_day) = 'Mar' then '1'
            when MONTHNAME(a.date_day) = 'Apr' then '1'
            when MONTHNAME(a.date_day) = 'May' then '1'
            when MONTHNAME(a.date_day) = 'Jun' then '1'
            when MONTHNAME(a.date_day) = 'Jul' then '2'
            when MONTHNAME(a.date_day) = 'Aug' then '2'
            when MONTHNAME(a.date_day) = 'Sep' then '2'
            when MONTHNAME(a.date_day) = 'Oct' then '2'
            when MONTHNAME(a.date_day) = 'Nov' then '2'
            when MONTHNAME(a.date_day) = 'Dec' then '2'
          
            end as semester

    FROM date_spine AS a 
    )

SELECT * FROM dim_year_month_day

