select
a.email
from
{{ ref('dim_users_detail') }} AS a
where
a.email not like '%@%'