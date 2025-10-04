{{
    config(
    materialized='incremental',
    unique_key = ['id_cliente']
    )
}}

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