select
a.delivery_date
from
{{ ref('int_orders') }} AS a
where
a.creation_date > a.delivery_date