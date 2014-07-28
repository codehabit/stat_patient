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
  if $(".tooth-chart-annotate").length > 0
    $(".tooth-chart-annotate").annotateImage
      editable: true
      useAjax: true
      getUrl: $(".tooth-chart-annotate").data("index")
      createUrl: $(".tooth-chart-annotate").data("index")
      deleteUrl: $(".tooth-chart-annotate").data("index")

