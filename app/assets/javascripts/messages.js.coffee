$(document).on "ready page:load", ->
  $("[data-role='patient-select']").select2(
    width: "75%"
  )

