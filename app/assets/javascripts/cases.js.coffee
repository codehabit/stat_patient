$(document).on "ready page:load", ->
  $("[data-role='select2']").select2(
    placeholder: $(this).attr("placeholder")
    height: "10"
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

  $("#dialog").dialog
    autoOpen: false
    draggable: false
    close: ->
      $(".temp-selected").removeClass("temp-selected ui-selected")

  $("#selectable").selectable
    selected: ->
      $(".ui-selected").addClass("temp-selected")
    stop: (e) ->
      $("#dialog").dialog "option", "position",
        my: "center",
        at: "center",
        of: e
      $("#dialog").dialog "option", "title", "Choose an option"
      $("#dialog").dialog "option", "modal", true
      $("#dialog").dialog "open"

  $(document).on "click", "[data-role='urgent-toggle']", (evt)->
    evt.preventDefault()
    self = $(this)
    self.blur()
    form_field = $(self.data("target"))
    current_value = form_field.val()
    marked = current_value == "true"
    form_field.val(!marked)
    current_value = form_field.val()
    marked = current_value == "true"
    button_text = if marked then "Unmark as urgent" else "Mark as urgent"
    self.text(button_text)
