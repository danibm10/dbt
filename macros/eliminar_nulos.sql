{% macro eliminar_nulos(columna,actual,cambio) %}

case
    when ifnull({{ columna }},'pepon')=ifnull({{ actual }},'pepon') then {{ cambio }}

    else {{ columna }}
end
{% endmacro %}