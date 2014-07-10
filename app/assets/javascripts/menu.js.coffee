$(document).on "ready page:load", ->

  $(document).on "click", "[data-role='close-menu']", ->
    target = $(this).data('target')
    url = "#{target}?collapsed=true"
    $('#main-menu').collapse('hide')
    $(".main-business").animate
      height: "100%"
    , 500
    window.location = url

  $(document).on "click", "[data-role='open-menu']", ->
    target= window.location.pathname
    url = "#{target}?collapsed=false"
    $('#main-menu').collapse('show')
    $(".main-business").animate
      height: "100%"
    , 500
    window.location = url

  $('#main-menu').on 'hidden.bs.collapse', ->

  #$('[data-role="patient-form"]')input').change ->
  $('#_patient').change ->
    $(this).closest('form').submit()
