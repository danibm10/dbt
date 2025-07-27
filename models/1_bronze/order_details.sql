
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
    date_ingestion
from
    {{source('staging', 'order_details')}}
order by 1

)

select * from order_details