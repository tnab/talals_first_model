view: orders {
  sql_table_name: demo_db.orders ;;

#   dimension: foo {
#     type: string
#     sql:  "foo" ;;
#   }
#
#   dimension: boo {
#     type: string
#     sql: {{orders.foo._value}} ;;
#   }

  parameter: foo  {
    type: string
    allowed_value: {
      value: "cancelled"
    }
    allowed_value: {
      value: "pending"
    }
    allowed_value: {
      value: "complete"
    }
    allowed_value: {
      value: "all"
    }
  }

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }


# measure: test_count_weekdays{
#   type: number
#   sql:  DATEDIFF(${created_date},   ;;
# }
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

  parameter: timeframe_picker {
    label: "Date Granularity"
    type: string
    allowed_value: { value: "Date" }
    allowed_value: { value: "Week" }
    allowed_value: { value: "Month" }
    default_value: "Date"
  }

  dimension: dynamic_timeframe {
    type: string
    sql:
    CASE
    WHEN {% parameter timeframe_picker %} = 'Date' THEN ${created_date}
    WHEN {% parameter timeframe_picker %} = 'Week' THEN ${created_week}
    WHEN {% parameter timeframe_picker %} = 'Month' THEN ${created_month}
    END ;;
  }


  dimension: status {
    type: string
    sql: ${TABLE}.statsus ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [id, users.first_name, users.last_name, users.id, order_items.count]
  }

# This takes a 30 day window and shifts it back to start the 30 day period from last ETL date as opposed to starting it from today
  filter: shift_time_filter {
    type: date
    sql: {% condition %} DATE_ADD(CAST(${created_time} AS DATETIME),
    INTERVAL DATEDIFF(CONVERT_TZ(NOW(), 'UTC', '{{ _query._query_timezone }}'),
    (SELECT max(CAST(${created_time} AS DATETIME)) as max_date from ${TABLE})) DAY) {% endcondition %} ;;
  }
}
