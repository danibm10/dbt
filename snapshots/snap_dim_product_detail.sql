{% snapshot snap_dim_products_detail %}

{{
    config(
      target_schema='snapshots',
      unique_key='product_detail_id',
      strategy='timestamp',
      updated_at='_fivetran_synced',
    )
}}

select * from {{ ref('int_products_detail') }}

{% endsnapshot %}