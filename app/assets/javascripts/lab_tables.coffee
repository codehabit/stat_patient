add_row = (id, to) ->
  $.get "/laboratory_orders/table_row/#{id}", (data) ->
    selector = "[data-role='#{to}'] table"
    list = $(selector)
    list.dataTable().fnDestroy()
    list.prepend(data)
    initLabsTable(to)
    hookup_row_links()

find_row = (id) ->
  table = $("[data-role='active-orders'] table").DataTable()
  table.row("[data-id=#{id}]")

first_row = ->
  inbox = $("[data-role='active-orders'] table tr:eq(0)")

setup_live = ->
  if window.location.pathname == "/"
    source = new EventSource('/laboratory_orders/live')
    source.addEventListener 'message', (e) ->
      data = $.parseJSON(e.data)
      $.each data.ids, (index, id) ->
        row = find_row(id)
        first_row = $("[data-role='active-orders'] table tr:eq(0)")
        if row && first_row.data("id") != id
          row.remove().draw(false)
          add_row(id, "inbox")
        else
          add_row(id, "inbox")

$(document).on "click", "[data-role='order-closer']", (e) ->
  e.preventDefault()
  console.log("hi there")
  $.ajax
    method: "PUT"
    url: $(this).data("target")
    data: JSON.stringify(list_type: "closed")
    dataType: "json"
    contentType: "application/json"
    success: (data) ->
      id = data.id
      $("[data-role='active-orders'] [data-id=#{id}]").remove()
      add_row(id, "closed-orders")

# $(document).on "ready page:load", ->
#   setup_live()
