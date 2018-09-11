view: users {
  sql_table_name: demo_db.users ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: failed_case_test {
    type: string
    case: {
      when: {
        sql:${TABLE}.city = "Agency"  ;;
        label: "test_successful"
      }
      when: {
        sql:${TABLE}.city = "Addis"  ;;
        label: "test_successful"
      }
      when: {
        sql:${TABLE}.city = "Akron"  ;;
        label: "test_successful"
      }
      else: "nope"
    }
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
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

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }

  measure: count {
    type: count
    drill_fields: [details*]
  }

  # ----- Sets of fields for drilling ------
  set: details {
    fields: [
      id,
      first_name,
      last_name,
      age,
      events.count,
      orders.count,
      user_data.count,
      state
    ]
  }
}
