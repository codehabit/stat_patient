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

  $("[data-role='zoom']").elevateZoom()

$(window).load ->
  $(".tooth-chart").annotateImage
    editable: true
    useAjax: false
