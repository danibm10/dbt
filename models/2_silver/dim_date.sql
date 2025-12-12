{{ config(
    materialized='table'
) }}

with base as (
{{ dbt_date.get_date_dimension("2025-01-01", "2026-12-31") }}
)

select
    cast(format_date('%Y%m%d', date_day) as int64) as sk_date,
    date_day,
    day_of_week_name,
    day_of_week,
    day_of_month,
    day_of_year,
    week_of_year,
    month_name
    month_name_short,
    month_of_year,
    quarter_of_year,
    quarter_start_date,
    quarter_end_date,
    year_number,
    year_start_date,
    year_end_date
from base