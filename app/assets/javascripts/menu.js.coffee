$ ->
  #$(document).on "click", "[data-role='open-menu']", (e) ->
  #  menu = $('#main-menu')
  #  current_state = $.totalStorage('context-bar-state')
  #  new_state = if (current_state == 'closed') then 'open' else 'closed'
  #  $.totalStorage('context-bar-state', new_state)

  #  if new_state == 'open'
  #    menu.show('blind')
  #  else
  #    menu.hide('blind')

ready = ->
 # menu = $('#main-menu')
 # main_menu_visible = menu.css('display') != 'none'
 # desired_state = $.totalStorage('context-bar-state')

 # if desired_state == 'closed' && main_menu_visible
 #   menu.hide()

 # if desired_state == 'open' && !main_menu_visible
 #   menu.show()

 # $(document).on "click", ".context-bar-menu [data-role='close-menu']", ->
 #   $.totalStorage('context-bar-state', 'closed')
 #   menu.hide('blind') if main_menu_visible

 # $('#_patient').change ->
 #   $(this).closest('form').submit()

 # $('[data-role="coming-soon"]').hover ->
 #   message =  $(this).data('message') + ' is coming soon.'
 #   $(this).tooltip( title: message)

$(document).ready(ready)
$(document).on('page:load', ready)
