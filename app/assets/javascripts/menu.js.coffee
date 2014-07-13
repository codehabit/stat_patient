$ ->
  $(document).on "click", "[data-role='open-menu']", (e) ->
    menu = $('#main-menu')
    current_state = $.totalStorage('context-bar-state')
    new_state = if (current_state == 'closed') then 'open' else 'closed'
    $.totalStorage('context-bar-state', new_state)

    console.log "toggling #{current_state} -> #{new_state}"
    if new_state == 'open'
      menu.show('blind')
    else
      menu.hide('blind')

ready = ->
  menu = $('#main-menu')
  main_menu_visible= menu.is(":visible")
  state = $.totalStorage('context-bar-state')
  console.log "desired_state is #{state}"

  if state == 'closed' && main_menu_visible
    console.log 'closing on load'
    menu.hide()

  if state == 'open' && !main_menu_visible
    console.log 'opening on load'
    menu.show()

  $(document).on "click", ".context-bar-menu [data-role='close-menu']", ->
    $.totalStorage('context-bar-state', 'closed')
    menu.hide('blind') if main_menu_visible


  $('#_patient').change ->
    $(this).closest('form').submit()

$(document).ready(ready)
$(document).on('page:load', ready)
