$(document).on "ready page:load", ->

  $(document).on "click", "[data-role='close-menu']", ->
    $('#main-menu').collapse('toggle')
    $(".main-business").animate
      height: "600"
    , 500

  $(document).on "click", "[data-role='open-menu']", ->
    $('#main-menu').collapse('show')
    $(".main-business").animate
      height: "320"
    , 500

  $('#main-menu').on 'hidden.bs.collapse', ->
