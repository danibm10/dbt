{{
  config(
    materialized='view'
  )
}}

WITH intermediate_client AS (
    SELECT * 
    FROM {{ ref('snap_dim_clients_detail') }}
    ),

dim_client_detail AS (
    SELECT
          a.client_detail_id
        , a.client_id
        , a.phone_number
        , a.email
        , CONCAT(SUBSTRING(a.dbt_valid_from, 1, 10),' - ',SUBSTRING(a.dbt_valid_from, 12, 8)) as valid_from
        , a.dbt_valid_to AS valid_to
        
    FROM intermediate_client AS a
   
    )

SELECT * FROM dim_client_detail