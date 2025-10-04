{% snapshot clientes_snapshot %}

    {{
        config(
            target_schema='snapshots',
            unique_key='id_cliente',
            strategy='timestamp',
            updated_at='fecha_creacion'
        )
    }}
    
    select * from {{ ref('clientes') }}

{% endsnapshot %}
