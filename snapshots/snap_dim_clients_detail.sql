{% snapshot snap_dim_clients_detail %}

{{
    config(
      target_schema='snapshots',
      unique_key='client_detail_id',
      strategy='timestamp',
      updated_at='_fivetran_synced',
    )
}}

select * from {{ ref('stg_client_detail') }}

{% endsnapshot %}