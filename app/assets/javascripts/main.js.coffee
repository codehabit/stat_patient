$(document).on "ready page:load", ->

  $('[data-role="link-selector"]').on "click", () ->
    window.location = $(this).data('target')

  $(document).on "click", "[data-role='signout']", ->
    $.totalStorage('context-bar-state', 'open')

  $('[data-role="select2"]').select2()

