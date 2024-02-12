{{ config(materialized='incremental', unique_key='date')}}

SELECT * FROM public.dates d
WHERE date <= current_date

{% if is_incremental() %}
 AND date > (SELECT max(date) from {{ this }})
{% endif %}