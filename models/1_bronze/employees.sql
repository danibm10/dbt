
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
    date_ingestion
from
    {{source('staging', 'employees')}}
order by 1

)

select * from employees