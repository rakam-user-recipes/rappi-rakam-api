{
  name : "hourly_events_by_platform",
  sql : |||
   SELECT date_trunc('hour', _time) as hour,
          event_type, 
          properties:platform::string as platform,
          count(*) as total_events
   FROM FIVETRAN.RAKAM_EVENTS.EVENTS 
   {% if is_incremental() %}
    WHERE hour > (select max(hour) from {{this}})
   {% endif %}
   GROUP BY 1, 2, 3
   
  |||,
  persist : {
    unique_key : "concat(event_type, platform, hour)",
    materialized : "incremental",
    incremental_strategy : "merge"
  },
  mappings : { },
  measures : {
    count_all_rows : {
      description : "Counts All Rows",
      reportOptions : {
        formatNumbers : true
      },
      aggregation : "count",
      type : "double"
    }
  },
  _path : "hourly_events_by_platform.model.jsonnet"
}