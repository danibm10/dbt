{{
  config(
    materialized='view'
  )
}}

WITH intermediate_client AS (
    SELECT * 
    FROM {{ ref('snap_dim_users_detail') }}
    ),

int_users_detail AS (
    SELECT * 
    FROM {{ ref('int_users_detail')}}
    ),

dim_users_detail AS (
    SELECT DISTINCT
          a.user_detail_id
        , a.user_id
        , a.phone_number
        , a.email
        , CONCAT(SUBSTRING(a.dbt_valid_from, 1, 10),' - ',SUBSTRING(a.dbt_valid_from, 12, 8)) as valid_from
        , a.dbt_valid_to AS valid_to
        
    FROM intermediate_client AS a
   
    )

SELECT * FROM dim_users_detail