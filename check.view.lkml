view: check {
  # Or, you could make this view a derived table, like this:
  derived_table: {
    sql: SELECT
         MAX(orders.created_at) as last_date
      FROM orders
      GROUP BY user_id
      ;;
  }


dimension: last_date  {}

dimension: last_30_days_in_table {
  type: yesno
  sql: orders.created_at < dateadd(created_at, INTERVAL -30 DAY)  ;;
}


}
