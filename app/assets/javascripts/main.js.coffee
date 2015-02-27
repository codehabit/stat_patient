window.mainSetup = ->

  $('[data-role="link-selector"]').on "click", () ->
    window.location = $(this).data('target')

  $(document).on "click", "[data-role='signout']", ->
    $.totalStorage('context-bar-state', 'open')

  $('[data-role="select2"]').select2()

  $(".equal-height-container").each ->
    highestBox = 0
    $(".equal-height-div", this).each ->
      if $(this).height() > highestBox
        highestBox = $(this).height()

    $(".equal-height-div").each (index, element) ->
      $(element).height highestBox

$(document).on('ready page:load', mainSetup)

