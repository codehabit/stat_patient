$(document).on "ready page:load", ->

  $(document).on "click", "[data-role='close-menu']", ->
    $('#main-menu').collapse('hide')
    $(".main-business").animate
      height: "100%"
    , 500

  $(document).on "click", "[data-role='open-menu']", ->
    $('#main-menu').collapse('show')
    $(".main-business").animate
      height: "100%"
    , 500

  $('#main-menu').on 'hidden.bs.collapse', ->

  #$('[data-role="patient-form"]')input').change ->
  $('#_patient').change ->
    $(this).closest('form').submit()
