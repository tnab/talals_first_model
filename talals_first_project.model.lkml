connection: "thelook"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

datagroup: talals_first_project_default_datagroup {
  sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: talals_first_project_default_datagroup

explore: product_exploration  {
  label: "Products"
  join: products {
      type: left_outer
    sql_on: ${product_exploration.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: order_items {
    sql_on: ${product_exploration.id} = ${order_items.inventory_item_id} ;;
    relationship: one_to_many
  }
}

explore: user_exploration {
  sql_always_where: ${users.age} > 0 AND ${users.age} < 100   ;;
  label: "Users"
  join: users {
    sql_on: ${user_exploration.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: user_data {
    sql_on: ${user_data.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

}



explore: order_items {
  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}
