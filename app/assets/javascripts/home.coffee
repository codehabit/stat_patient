$(document).on "ready page:load", ->
  source = new EventSource('/home/live')
  source.addEventListener 'message', (e) ->
    data = $.parseJSON(e.data)
    $.each data.ids, (index, id) ->
      $("[data-id='#{id}']").addClass("unread")
      $("[data-id='#{id}']").removeClass("read")

$(document).on "click", "[data-role='message-list-selector']", ->
  target_selector = "[data-role='#{$(this).data("target")}']"
  $("[data-showing]").hide()
  $(target_selector).attr("data-showing", true)
  $(".menu-item.active").removeClass("active")
  $(this).closest(".menu-item").addClass("active")
  $(target_selector).show()

