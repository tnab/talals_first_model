view: user_data {
  sql_table_name: demo_db.user_data ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: max_num_orders {
    type: number
    sql: ${TABLE}.max_num_orders ;;
  }

  dimension: total_num_orders {
    type: number
    sql: ${TABLE}.total_num_orders ;;
  }

#   Customer Segmentation by Age
  dimension: age_group {
    type: tier
    tiers: [19, 31, 51]
    label: "Customer Age Group"
    style:  integer
    sql: ${users.age} ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }


  measure: count {
    type: count
    drill_fields: [id, users.first_name, users.last_name, users.id]
  }
}
