view: inventory_items {
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

  dimension_group: start {
    type: time
    timeframes: [raw, day_of_week_index] ## you can have other timeframes here too
    sql: ${TABLE}.created_at
      ;;
  }

  dimension_group: stop {
    type: time
    timeframes: [raw, day_of_week_index] ## same here!
    sql: ${TABLE}.sold_at
      ;;
  }

  dimension: count_weekdays {
    type: number
    sql: DATEDIFF(${start_raw}, ${stop_raw}) - (FLOOR(DATEDIFF(${start_raw}, ${stop_raw}) / 7) * 2) +
      CASE WHEN DAYOFWEEK(${start_day_of_week_index}) - DAYOFWEEK(${stop_day_of_week_index}) IN (1, 2, 3, 4, 5) AND DAYOFWEEK(${stop_day_of_week_index}) != 0
      THEN 2 ELSE 0 END +
      CASE WHEN DAYOFWEEK(${start_day_of_week_index}) != 0 AND DAYOFWEEK(${stop_day_of_week_index}) = 0
      THEN 1 ELSE 0 END +
      CASE WHEN DAYOFWEEK(${start_day_of_week_index}) = 0 AND DAYOFWEEK(${stop_day_of_week_index}) != 0
      THEN 1 ELSE 0 END;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      day_of_week,
      day_of_week_index,
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

  dimension_group: sold {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      day_of_week,
      day_of_week_index,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.sold_at ;;
  }

  measure: count {
    type: count
    drill_fields: [id, products.item_name, products.id, order_items.count]
  }
}
