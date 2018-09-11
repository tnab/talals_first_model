view: check {
  # Or, you could make this view a derived table, like this:
  derived_table: {
    sql: SELECT
        orders.created_date as created_date
        , MAX(orders.created_date) as last_date
      FROM orders
      GROUP BY 1
      ;;
  }


dimension: created_date  {}
dimension: last_date  {}

dimension: last_30_days_in_table {
  type: yesno
  sql: orders.created_date < dateadd(created_date, INTERVAL -30 DAY)  ;;
}


}
