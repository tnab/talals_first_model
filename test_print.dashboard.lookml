- dashboard: products
  title: Products
  layout: newspaper
  elements:
  - title: test tile to delete
    name: test tile to delete
    model: talals_first_project
    explore: order_items
    type: table
    fields:
    - orders.status
    - orders.count
    sorts:
    - orders.count desc
    limit: 500
    query_timezone: America/Los_Angeles
    row: 10
    col: 0
    width: 8
    height: 6
  - name: merge-MxBYXkrKTywUXv5bY5bivN-2465
    type: text
    title_text: New Tile
    subtitle_text: This item contains data that can no longer be displayed.
    body_text: This item contains results merged from two or more queries. This is
      currently not supported in LookML dashboards.
    row: 0
    col: 0
    width: 23
    height: 10
