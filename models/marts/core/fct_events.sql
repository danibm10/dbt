WITH stg_events AS (
    SELECT * 
    FROM {{ ref('stg_events')}}
    ),

dim_year_month_day1 AS (
    SELECT * 
    FROM {{ ref('dim_year_month_day') }}
    ), 

fct_events AS (
    SELECT
          a.event_id
        , a.user_id
        , {{ eliminar_nulos('a.product_id',"''") }} as product_id  
        , b.year_month_day_id
        , {{ eliminar_nulos('a.order_id',"''") }} as order_id  
        , a.session_id
        , a.page_url
        , a.event_type
        , a.created_at_time
        , CASE
            when a.order_id = '' then 'No Compra'
            else 'Compra'
            end as purchase_indicator
        , a.sync_date
        , a.sync_time

    FROM stg_events AS a LEFT JOIN dim_year_month_day1 AS b
    ON a.created_at_day = b.year_month_day_id
    )

SELECT * FROM fct_events