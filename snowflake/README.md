# Rakam API Integration

## How does it work?

Rakam ingests all the event data into a table called `EVENTS`. This recipe extracts the event types and its properties from the table and creates models for each event type. Additionally it has models that all models and some system related models such as invalid_schema.

## Adding a common metric to all events
[./common_schema.libsonnet](common_schema.libsonnet) has measures, dimensions, and mappings that applies to all_events and custom_events. If you want to add a metric that should be visible in all these events, you can add it there.

## Adding a metric to an individual event
Similar to the common file, there is [./predefined_schema.libsonnet](predefined_schema.libsonnet) that includes event_type to model definitions. The key is the event type and the values `measures`, `dimensions` and will be applied to your events upon recipe update.
