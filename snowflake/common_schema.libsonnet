{
  measures: {
    unique_users: {
      aggregation: 'countUnique',
      sql: '{{dimension.user}}',
    },
    unique_devices: {
      aggregation: 'countUnique',
      sql: '{{dimension.device_id}}',
    },
    unique_sessions: {
      aggregation: 'countUnique',
      sql: '{{dimension.session_id}}',
    },
    total_events: {
      aggregation: 'count',
    },
  },
  dimensions: {
    __ip: {
      category: 'User Location',
    },
    _city: {
      category: 'User Location',
    },
    _region: {
      category: 'User Location',
    },
    _country_code: {
      category: 'User Location',
    },
    _latitude: {
      category: 'User Location',
    },
    _device_brand: {
      category: 'User Location',
    },
    _device_carrier: {
      category: 'User Location',
    },
    _device_family: {
      category: 'User Location',
    },
    _device_id: {
      category: 'User Location',
    },
    _device_manufacturer: {
      category: 'User Location',
    },
    _device_model: {
      category: 'User Location',
    },
  },
  columns: {
    time: {
      column: '_TIME',
      description: '',
      type: 'timestamp',
    },
    server_time: {
      column: '_SERVER_TIME',
      description: '',
      type: 'timestamp',
    },
    user: {
      column: '_USER',
      description: '',
    },
  },
  mappings: {
    eventTimestamp: 'time',
    userId: 'user',
    deviceId: 'device_id',
  },
}
