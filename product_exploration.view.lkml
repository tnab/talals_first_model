view: product_exploration {
  sql_table_name: demo_db.inventory_items ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
    value_format_name: usd
  }

  filter: foo {
    type: number
    description: "test"
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: product_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.product_id ;;
  }

  dimension: profit {
    type: number
    sql: ${order_items.sale_price} - ${TABLE}.cost ;;
    value_format_name: usd
  }

  dimension_group: sold {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.sold_at ;;
  }


  measure: total_revenue {
    type: sum
    sql: ${order_items.sale_price} ;;
    value_format_name: usd
  }

  measure: total_cost {
    type: sum
    sql: ${TABLE}.cost ;;
    value_format_name: usd
  }

  measure: test_profit {
    type: sum
    sql: (${order_items.sale_price} - ${TABLE}.cost) ;;
    value_format_name: usd
  }

  measure: total_profit {
    type: sum
    sql: ${profit} ;;
    value_format_name: usd
  }

  measure: avg_category_profit {
    label: "Average Profit"
    type:  average
  }

  measure: testing {
    type: number
    sql: ${products.brand_count} / ${count} ;;
  }

  measure: count {
    type: count
    drill_fields: [id, products.item_name, products.id, order_items.count]
  }
}
