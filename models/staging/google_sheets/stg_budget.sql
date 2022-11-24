{{
  config(
    materialized='view'
  )
}}

WITH stg_google_sheets_budget AS (
    SELECT * 
    FROM {{ ref('base_google_sheets_budget') }}
    ),
 

stg_budget AS (
    SELECT
          a._row AS budget_id
        , a.quantity
        , a.month
        , a.product_id
        , a.fecha_sincronizacion
        , a.hora_sincronizacion
     
    FROM stg_google_sheets_budget AS a
    )

SELECT * FROM stg_budget