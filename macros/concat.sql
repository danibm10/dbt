{%- macro concatenamos(columna) -%}
    concat({{ columna }}, '00000')
{%- endmacro -%}