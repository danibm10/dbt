{{
    config(
    materialized='incremental',
    unique_key=['id']
    )
}}

WITH fact_sales AS (
SELECT
    b.id,
    b.order_id,
    b.product_id,
    a.customer_id,
    a.employee_id,
    a.shipper_id,
    b.quantity,
    b.unit_price,
    b.discount,
    b.status_id,
    b.date_allocated,
    b.purchase_order_id,
    b.inventory_id,
    a.order_date,
    a.shipped_date,
    a.paid_date,
    b.date_ingestion
FROM
    {{ref('orders')}} AS a
LEFT JOIN 
    {{ref('order_details')}} AS b
ON 
    b.order_id = a.id
WHERE 
    b.id is not null
{% if is_incremental() %}
AND a.date_ingestion > (SELECT MAX(a.date_ingestion) FROM {{ this }} )  
{% endif %}
ORDER BY 
    b.order_id DESC
)

SELECT * FROM fact_sales