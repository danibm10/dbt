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
        , MONTHNAME(a.month) AS MONTH
        , a.product_id
        , CAST(SUBSTRING(_fivetran_synced, 1, 10) AS DATE) AS FECHA_SINCRONIZACION
        , CAST(SUBSTRING(_fivetran_synced, 12, 8) AS TIME) AS HORA_SINCRONIZACION
    FROM src_google_sheets_budget AS a
    )

SELECT * FROM budget_v1