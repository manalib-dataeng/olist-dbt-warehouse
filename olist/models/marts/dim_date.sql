with spine as (
    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="cast('2016-01-01' as date)",
        end_date="cast('2019-01-01' as date)") }}
)
select
    cast(date_day as date)         as date_key,
    extract(year from date_day)    as year,
    extract(month from date_day)   as month,
    strftime(date_day, '%Y-%m')    as year_month,
    dayname(date_day)              as day_name
from spine