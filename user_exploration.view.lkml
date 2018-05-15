view: user_exploration {
  sql_table_name: demo_db.user_data ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

#   Customer Segmentation by Age
  dimension: age_group {
    type: tier
    tiers: [19, 31, 51]
    label: "Customer Age Group"
    style:  integer
    sql: ${users.age} ;;
    drill_fields: [users.details*]
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }


  measure: count {
    type: count
    drill_fields: [users.details*]
  }

  # Not really indicative of anything, just testing
  measure: minimum {
    type: min
    sql: ${users.age} ;;
    drill_fields: [users.details*]

  }

}
