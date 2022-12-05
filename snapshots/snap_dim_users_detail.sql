{% snapshot snap_dim_users_detail %}

{{
    config(
      target_schema='snapshots',
      unique_key='user_id',
      strategy='timestamp',
      updated_at='_fivetran_synced',
      tags= 'snapshot'
    )
}}

select * from {{ ref('int_users_detail') }}

{% endsnapshot %}