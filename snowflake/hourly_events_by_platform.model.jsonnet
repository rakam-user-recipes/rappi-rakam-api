{
  name : "hourly_events_by_platform",
  sql : |||
   SELECT date_trunc('hour', _time) as hour,
          event_type, 
          properties:platform::string as platform,
          count(*)
   FROM FIVETRAN.RAKAM_EVENTS.EVENTS 
   {% if is_incremental() %}
    WHERE hour > (select max(hour) from {{this}})
   {% endif %}
   GROUP BY 1, 2, 3
  |||,
  persist : {
    materialized : "incremental",
    incremental_strategy : "merge",
    unique_key : "concat(event_type, platform, hour)"
  },
  mappings : { }
}