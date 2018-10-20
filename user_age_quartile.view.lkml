view: user_age_quartile{

  derived_table: {
    sql:
    SELECT id AS user_id,
    NTILE(4) OVER (ORDER BY age) as quartile
    FROM demo_db.users
    ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }
  dimension: quartile {
    type: number
    sql: ${TABLE}.quartile ;;
    }

#   parameter: bucket_size {
#     default_value: "10"
#     type: number
#   }

}
