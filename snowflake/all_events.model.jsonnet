local common = import 'common_schema.libsonnet';

{
  name: 'rakam_events',
  label: '[Rakam] All events',
  target: std.extVar('target'),
  category: 'Rakam Events',
  measures: common.measures,
  mappings: common.mappings,
  dimensions: common.columns {
    event_type: {
      column: 'EVENT_TYPE',
    },
  },
}
