$(document).on "ready page:load", ->
  if window.location.pathname == "/"
    source = new EventSource('/home/live')
    source.addEventListener 'message', (e) ->
      $.get '/home/inbox', (data) ->
        $("[data-role='inbox']").html(data)
        initDataTables()
        mainSetup()
