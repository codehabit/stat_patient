$(document).on "ready page:load", ->
  $("[data-role='patient-select']").select2(
    placeholder: "Select a patient"
    width: "75%"
  )

  $("[data-role='recipient-select']").select2(
    placeholder: "Select a recipient"
    width: "75%"
  )

