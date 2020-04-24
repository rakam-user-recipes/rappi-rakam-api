{{
  config(
   
    alias = "HOURLY_EVENTS_BY_PLATFORM",
    unique_key = "concat(event_type, platform, hour)",
    materialized = "incremental",
    incremental_strategy = "merge"
  )
}}
SELECT date_trunc('hour', _time) as hour,
       event_type, 
       properties:platform::string as platform,
       count(*) as total_events
FROM FIVETRAN.RAKAM_EVENTS.EVENTS WHERE _time > cast('2020-01-01')
{% if is_incremental() %}
 AND hour > (select max(hour) from {{this}})
{% endif %}
GROUP BY 1, 2, 3

