remove_from_sent = (id) ->
  sent_row = $("[data-role='sent'] [data-id='#{id}']")
  sent = $("[data-role='sent'] table")
  if sent_row.length == 1
    sent.dataTable().fnDestroy()
    sent_row.remove()
    initTable(sent)

add_row = (id) ->
  $.get "/home/table_row/#{id}", (data) ->
    inbox = $("[data-role='inbox'] table")
    inbox.dataTable().fnDestroy()
    inbox.prepend(data)
    initTable(inbox)
    hookup_row_links()

find_row = (id) ->
  table = $("[data-role='inbox'] table").DataTable()
  table.row("[data-id=#{id}]")

first_row = ->
  inbox = $("[data-role='inbox'] table tr:eq(0)")

setup_live = ->
  if window.location.pathname == "/"
    source = new EventSource('/home/live')
    source.addEventListener 'message', (e) ->
      console.log("hello")
      data = $.parseJSON(e.data)
      $.each data.ids, (index, id) ->
        row = find_row(id)
        first_row = $("[data-role='inbox'] table tr:eq(0)")
        if row && first_row.data("id") != id
          row.remove().draw(false)
          add_row(id)
        else
          add_row(id)

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

