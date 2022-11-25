{% snapshot dim_product_detail %}

{{
    config(
      target_schema='snapshots',
      unique_key='product_detail_id',
      strategy='timestamp',
      updated_at='_fivetran_synced',
    )
}}

select * from {{ ref('stg_product_detail') }}

{% endsnapshot %}