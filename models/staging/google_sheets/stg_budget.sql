{{
  config(
    materialized='view'
  )
}}

WITH src_google_sheets_budget AS (
    SELECT * 
    FROM {{ source('src_budget', 'budget') }}
    ),

budget_v1 AS (
    SELECT
          a._row
        , a.quantity
        , a.month AS DATE
        , a.product_id
        , CAST(SUBSTRING(_fivetran_synced, 1, 10) AS DATE) AS sync_date
        , CAST(SUBSTRING(_fivetran_synced, 12, 8) AS TIME) AS sync_time
    FROM src_google_sheets_budget AS a
    )

SELECT * FROM budget_v1