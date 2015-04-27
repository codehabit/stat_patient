remove_from_sent = (id) ->
  sent_row = $("[data-role='sent'] [data-id='#{id}']")
  sent = $("[data-role='sent'] table")
  if sent_row.length == 1
    sent.dataTable().fnDestroy()
    sent_row.remove()
    initTable(sent)

add_row = (id, to) ->
  $.get "/home/table_row/#{id}", (data) ->
    list = $("[data-role='#{to}'] table")
    list.dataTable().fnDestroy()
    list.prepend(data)
    initTable(list)
    hookup_row_links()
    $("[data-role='archived'] [data-id=#{id}]").remove() unless to == "archived"

find_row = (id) ->
  table = $("[data-role='inbox'] table").DataTable()
  table.row("[data-id=#{id}]")

first_row = ->
  inbox = $("[data-role='inbox'] table tr:eq(0)")

setup_live = ->
  if window.location.pathname == "/"
    source = new EventSource('/home/live')
    source.addEventListener 'message', (e) ->
      data = $.parseJSON(e.data)
      $.each data.ids, (index, id) ->
        row = find_row(id)
        first_row = $("[data-role='inbox'] table tr:eq(0)")
        if row && first_row.data("id") != id
          row.remove().draw(false)
          add_row(id, "inbox")
        else
          add_row(id, "inbox")

$(document).on "click", "[data-role='archiver']", (e) ->
  e.preventDefault()
  $.ajax
    method: "PUT"
    url: $(this).data("target")
    success: (data) ->
      id = data.id
      $("[data-role='inbox'] [data-id=#{id}]").remove()
      add_row(id, "archived")

$(document).on "click", "[data-role='restorer']", (e) ->
  e.preventDefault()
  $.ajax
    method: "PUT"
    url: $(this).data("target")
    success: (data) ->
      id = data.id
      $("[data-role='archived'] [data-id=#{id}]").remove()

$(document).on "ready page:load", ->
  setup_live()

$(document).on "click", "[data-role='message-list-selector']", (evt) ->
  evt.preventDefault()
  target_selector = "[data-role='#{$(this).data("target")}']"
  $("[data-showing]").hide()
  $(target_selector).attr("data-showing", true)
  $(".menu-item.active").removeClass("active")
  $(this).closest(".menu-item").addClass("active")
  $(target_selector).show()

