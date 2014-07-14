$(document).on "ready page:load", ->
  $("[data-role='select2']").select2(
    placeholder: $(this).attr("placeholder")
    width: "75%"
  )
  Dropzone.autoDiscover = false;
  $("[data-role='dropzone-enabled']").dropzone(
    # addRemoveLinks: true
    previewsContainer: "[data-role='image-previews']"
  )

$(document).on "click", "[data-toggle='modal']", ->
  trigger = $(this)
  modal = $(trigger.data("target"))
  console.log(modal)
  modal.modal()
