local common = import 'common_schema.libsonnet';
local predefined = import 'custom_schema.libsonnet';

local target = std.extVar('target');

std.map(function(event_type)
  local event_name = event_type.n;
  local db_name = event_type.db;

  local defined = if std.objectHas(predefined, event_name) then predefined[event_name] else null;

  local definedDimensions = if defined != null && std.objectHas(defined, 'dimensions') then defined.dimensions else {};
  local dimensions_for_event = std.foldl(function(a, b) a + b, std.map(function(prop) {
                                 [prop.n]: {
                                   sql: '{{TABLE}}.properties:"%(name)s"::%(type)s' % { type: prop.t, name: prop.db },
                                   label: if std.objectHas(definedDimensions, prop.n) && std.objectHas(definedDimensions[prop.n], 'label') then definedDimensions[prop.n].label
                                   else if std.objectHas(common.dimensions, prop.n) && std.objectHas(common.dimensions[prop.n], 'label') then common.dimensions[prop.n].label
                                   else null,
                                   category: if std.objectHas(definedDimensions, prop.n) && std.objectHas(definedDimensions[prop.n], 'category') then definedDimensions[prop.n].category
                                   else if std.objectHas(common.dimensions, prop.n) && std.objectHas(common.dimensions[prop.n], 'category') then common.dimensions[prop.n].category
                                   else if std.startsWith(prop.db, '_') then 'SDK'
                                   else 'Event Property',
                                 },
                               }, std.parseJson(event_type.props)), {})
                               +
                               if defined != null && std.objectHas(defined, 'computed_dimensions') then defined.computed_dimensions else {};
  {
    name: 'rakam_event_' + event_name,
    label: (if defined != null then '[SDK] ' else '') + event_name,
    sql: |||
      select * from "%(database)s"."%(schema)s"."%(table)s" where event_type = '%(event_name)s'
    ||| % { event_name: event_name, database: target.database, schema: target.schema, table: target.table },
    measures: common.measures + if defined != null && std.objectHas(defined, 'measures') then defined.measures else {},
    mappings: common.mappings,
    relations: if defined != null && std.objectHas(defined, 'relations') then defined.relations else {},
    category: 'Rakam Events',
    dimensions: common.columns + dimensions_for_event,
  }, std.extVar('event_schema'))
