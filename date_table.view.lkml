view: date_table {
  derived_table: {
    sql:
      WITH ALL_DAYS(DT) AS (
    VALUES (TIMESTAMP('2018-06-01 00:00:00'))
    UNION ALL
    SELECT DT + 1 MINUTE FROM ALL_DAYS WHERE DT <= TIMESTAMP('2018-07-01 00:00:00')
    )
    SELECT DT FROM ALL_DAYS  ;;
  }

  dimension:  DT  {}

}
