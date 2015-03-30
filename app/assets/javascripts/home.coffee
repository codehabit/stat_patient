# $(document).on "ready page:load", ->
#   if window.location.pathname == "/"
#     source = new EventSource('/home/live')
    # source.addEventListener 'message', (e) ->
    #   $.get '/home/inbox', (data) ->
    #     $("[data-role='inbox']").html(data)
    #     initDataTables()
    #     mainSetup()

$(document).on "click", "[data-role='message-list-selector']", ->
  target_selector = "[data-role='#{$(this).data("target")}']"
  $("[data-showing]").hide()
  $(target_selector).attr("data-showing", true)
  $(".menu-item.active").removeClass("active")
  $(this).closest(".menu-item").addClass("active")
  $(target_selector).show()

