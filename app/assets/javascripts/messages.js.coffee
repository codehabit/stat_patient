$(document).on "ready page:load", ->
  $("[data-role='patient-select']").select2(
    placeholder: "Select a patient"
    width: "75%"
  )

