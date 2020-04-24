{
  name : "hourly_events_by_platform",
  sql : |||
   SELECT date_trunc('hour', _time) as "hour",
          event_type as "event_type", 
          properties:platform::string as "platform",
          count(*) as "total_events"
   FROM FIVETRAN.RAKAM_EVENTS.EVENTS WHERE _time between cast('2020-04-01' as date) and cast('2020-04-30' as date)
   {% if is_incremental() %}
    AND hour > (select max(hour) from {{this}})
   {% endif %}
   GROUP BY 1, 2, 3
  |||,
  persist : {
    unique_key : "concat(event_type, platform, hour)",
    materialized : "incremental",
    incremental_strategy : "merge"
  },
  mappings : {
    eventTimestamp: 'hour'
  }, 
  measures : {
    total_events : {
      aggregation : "sum",
      column : "total_events"
    }
  },
  dimensions: {
    hour: {
      column: 'hour',
      type: 'timestamp',
    },
    event_type: {
      column: 'event_type',
      type: 'string',
    },
    platform: {
      column: 'platform',
      type: 'string',
    }
  }
}