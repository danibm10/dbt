with orders as (select
    id,
    employee_id,
    customer_id,
    order_date,
    shipped_date,
    shipper_id,
    ship_name,
    ship_address,
    ship_city,
    ship_state_province,
    ship_zip_postal_code,
    ship_country_region,
    shipping_fee,
    taxes,
    payment_type,
    paid_date,
    notes,
    tax_rate,
    tax_status_id,
    status_id
from 
    {{source('staging', 'orders')}}
)

select * from orders