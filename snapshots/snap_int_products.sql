{% snapshot snap_int_products %}

{{
    config(
      target_schema='snapshots',
      unique_key='product_id',
      strategy='timestamp',
      updated_at='_fivetran_synced',
      tags= 'snapshot',
    )
}}

select * from {{ ref('int_products') }}

{% endsnapshot %}