{{
    config(
      tags= 'test',
    )
}}


select
a.product_unit_cost_usd
from
{{ ref('dim_products_detail') }} AS a
where
a.product_unit_cost_usd > a.price_usd