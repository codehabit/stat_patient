$(document).on "ready page:load", ->
  source = new EventSource('/home/live')
  source.addEventListener 'message', (e) ->
    console.log "Hi there"
    $.get '/home/inbox', (data) ->
      $("[data-role='inbox']").html(data)
      initDataTables()
