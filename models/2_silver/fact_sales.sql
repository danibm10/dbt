{{
    config(
    materialized='incremental',
    unique_key=['id']
    )
}}

with order_details as (
select distinct
    id,
    order_id,
    product_id,
    quantity,
    unit_price,
    discount,
    status_id,
    date_allocated,
    purchase_order_id,
    inventory_id,
    '2025-07-20' as ingestion_date
from
    {{source('staging', 'order_details')}}
{% if is_incremental() %}
where ingestion_date > (select max(ingestion_date) from {{ this }} )  
{% endif %}
order by 1

)

select * from customers