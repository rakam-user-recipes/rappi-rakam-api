{
  // event type name
  add_to_cart: {
    measures: {
      total_quantity: {
        sql: '{{dimension.quantity}}',
        aggregation: 'sum',
      },
    },
    // event properties
    dimensions: {
      // property name
      quantity: {
        category: 'Basket',
        description: 'How many products the user added to the basket?',
      },
      brand_name: {
        category: 'Product',
      },
    },
    // use computed_dimensions in case you want to create a computed property
    computed_dimensions: {
      example_computed_property: {
        category: 'Example Category',
        sql: '{{dimension.product_name}} - {{dimension.product_id}}',
      },
    },
    relations: {},
  },
}
