{{
    config(
    materialized='incremental',
    unique_key=['id']
    )
}}

with customers as (
select
    id,
    company,
    last_name,
    first_name,
    email_address,
    job_title,
    business_phone,
    home_phone,
    mobile_phone,
    fax_number,
    address,
    city,
    state_province,
    zip_postal_code,
    country_region,
    web_page,
    notes,
    attachments, 
    date_ingestion
from
    {{ref('customers')}}
{% if is_incremental() %}
where date_ingestion > (select max(date_ingestion) from {{ this }} )  
{% endif %}

)

select * from customers