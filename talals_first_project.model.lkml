  connection: "thelook"

# include all the views
include: "*.view"

datagroup: talals_first_project_default_datagroup {
  sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "4 hours"
}

persist_with: talals_first_project_default_datagroup

# explore: product_exploration  {
#   label: "Products"
#
#   join: products {
#       type: left_outer
#     sql_on: ${product_exploration.product_id} = ${products.id} ;;
#     relationship: many_to_one
#   }
#
#   join: order_items {
#     sql_on: ${product_exploration.id} = ${order_items.inventory_item_id} ;;
#     relationship: one_to_many
#   }
# }

explore: inventory_items {}

explore: date_table {}

explore: user_exploration {

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

explore: orders {}
explore: check {}
explore: user_age_quartile {}

explore: order_items {
#   sql_always_where:
#   ${orders.user_id} = {{_user_attributes['talal_test' ]| round: 0}};;
# access_filter: {
#   field: orders.user_id
#   user_attribute: talal_test
# }

#   sql_always_where:(
#   CASE
#     when {% parameter orders.foo %} = 'all' then 1=1
#     else ${orders.status} = {% parameter orders.foo %}
#     end
#      )
#     ;;
#       when {% parameter orders.foo %} = 'all' then 1=1

#   ${orders.status} = {% parameter orders.foo %}  ;;
  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

#   join: check {
#     sql_on: ${orders.created_date} = ${check.created_date} ;;
#     relationship: many_to_many
#   }

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
