{{
    config(
    materialized='incremental',
    unique_key = ['id_cliente']
    )
}}
/*with max_snow as (
    {% if is_incremental() %}
        select max(fecha_creacion) as max_snow_synced from {{ this }}
    {% else %}
        select null as max_snow_synced
    {% endif %}
),*/

with 
clientes_1 as (
    select
     id_cliente,
     nombre,
     email,
     telefono,
     direccion,
     estado,
     max(fecha_creacion) as fecha_creacion
    from {{source('staging', 'clientes')}}
    {% if is_incremental() %}
    where fecha_creacion > (select max(fecha_creacion) from {{ this }})
    {% endif %}
    group by
     id_cliente,
     nombre,
     email,
     telefono,
     direccion,
     estado

)

select * from clientes_1