{{
    config(
    materialized='incremental',
    unique_key=['id']
    )
}}

with employees as (
select distinct
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
    '2025-07-20' as ingestion_date
from
    {{source('staging', 'employees')}}
{% if is_incremental() %}
where ingestion_date > (select max(ingestion_date) from {{ this }} )  
{% endif %}
order by 1

)

select * from employees