SELECT
    o.customer_key,
    o.order_status,
    {{ rename_segments('o.order_priority') }} AS priority_segment_adjusted
FROM public.orders o
