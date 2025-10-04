{{
    config(
    materialized='incremental',
    unique_key=['id']
    )
}}

with order_details as (
select
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
    date_ingestion
from
    {{ref('order_details')}}
{% if is_incremental() %}
where date_ingestion > (select max(date_ingestion) from {{ this }} )  
{% endif %}

)

select * from order_details