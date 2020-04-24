{
  add_to_cart: {
    measures: {
      total_quantity: {
        sql: '{{dimension.quantity}}',
        aggregation: 'sum',
      },
    },
    dimensions: {
      quantity: {
        category: 'Basket',
        description: 'How many products the user added to the basket?',
      },
      brand_name: {
        category: 'Product',
      },
    },
    computed_dimensions: {
      example_computed_property: {
        category: 'Example Category',
        sql: '{{dimension.product_name}} - {{dimension.product_id}}',
      },
    },
    relations: {},
  },
}
