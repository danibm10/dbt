{% macro eliminar_nulos_bueno(columna,valor_actual="''",valor_nuevo="'Unknown'") -%}
case
    when {{ columna }} is null then {{ valor_nuevo }}
else
    replace ({{ columna }} , {{ valor_actual }} , {{ valor_nuevo }})

end
{%- endmacro %}