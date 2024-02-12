{{ config(materialized='table') }}

SELECT
    c.customer_key,
    c.name,
    c.nation_key AS nation,
    SUM(o.total_price) AS total_order_price
FROM public.customers c
LEFT JOIN public.orders o
    ON c.customer_key = o.customer_key
{{ group_by(3) }}
