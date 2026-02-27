{% test cantidad(model, column_name) %}

    select *
    from {{ model }}
    where {{ column_name }} < 5

{% endtest %}