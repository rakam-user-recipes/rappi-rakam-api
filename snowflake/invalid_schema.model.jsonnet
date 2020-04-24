local common = import 'common_schema.libsonnet';
local util = import 'util.libsonnet';
local target = std.extVar('target');

local dimensions = [
  {
    db: 'collection',
    n: 'collection',
    t: 'VARCHAR',
    desc: null,
  },
  {
    db: 'property',
    n: 'property',
    t: 'VARCHAR',
    desc: 'The property the system failed to parse in the collection',
  },
  {
    db: 'type',
    n: 'type',
    t: 'VARCHAR',
    desc: 'The expected type for the field. The system failed to parse the value to this type.',
  },
  {
    db: 'event_id',
    n: 'event_id',
    t: 'VARCHAR',
    desc: 'The id of the corresponding event in the EVENTS table. You can use this id in order to join to that table and fix the historical data.',
  },
  {
    db: 'error_message',
    n: 'error_message',
    t: 'VARCHAR',
    desc: 'The error message thrown in the system parsing the property ',
  },
  {
    db: 'encoded_value',
    n: 'encoded_value',
    t: 'VARCHAR',
    desc: 'aria-label="The invalid raw value encoded as JSON for that is sent to the API"',
  },
];

{
  category: 'Rakam Events',
  name: 'rakam_invalid_schema',
  label: '[System] Invalid Schema',
  description: 'Includes the parsing errors in the API. ',
  sql: |||
    select * from %(target)s where event_type = '$invalid_schema'
  ||| % { target: util.generate_target_reference(target) },
  measures: common.measures,
  mappings: common.mappings,
  dimensions: common.columns + std.foldl(function(a, b) a + b, std.map(function(prop) {
    [prop.n]: {
      sql: '{{TABLE}}.properties:"%(name)s"::%(type)s' % { type: prop.t, name: prop.db },
      category: if std.startsWith(prop.db, '_') then 'SDK' else 'Event Property',
      description: prop.desc,
    },
  }, dimensions), {}),
}
