$(document).on "ready page:load", ->

  $('[data-role="link-selector"]').on "click", () ->
    window.location = $(this).data('target')


