add_row = (id) ->
  $.get "/home/table_row/#{id}", (data) ->
    inbox = $("[data-role='inbox'] table")
    inbox.dataTable().fnDestroy()
    inbox.prepend(data)
    initTable(inbox)

$(document).on "ready page:load", ->
  if window.location.pathname == "/"
    source = new EventSource('/home/live')
    source.addEventListener 'message', (e) ->
      data = $.parseJSON(e.data)
      $.each data.ids, (index, id) ->
        existing_row = $("[data-id='#{id}']")
        if existing_row.length > 0
          existing_row.addClass("unread")
          existing_row.removeClass("read")
        else
          add_row(id)

$(document).on "click", "[data-role='message-list-selector']", ->
  target_selector = "[data-role='#{$(this).data("target")}']"
  $("[data-showing]").hide()
  $(target_selector).attr("data-showing", true)
  $(".menu-item.active").removeClass("active")
  $(this).closest(".menu-item").addClass("active")
  $(target_selector).show()

