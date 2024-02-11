{{ config(materialized='table') }}

SELECT DISTINCT order_date,
       SUM(total_price) OVER (ORDER BY order_date) AS cumulative_total_price
FROM public.orders o
ORDER BY order_date
