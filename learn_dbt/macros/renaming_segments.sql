{% macro rename_segments(column_name) %}
    CASE
        WHEN {{ column_name }} in ('1-URGENT', '2-HIGH')
            THEN 'segment-1'
        ELSE 'segment-2'
    END
{% endmacro %}