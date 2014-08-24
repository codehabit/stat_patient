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
  $(".annotate").each ->
    $(this).annotateImage
      editable: true
      useAjax: true
      getUrl: $(this).data("get-url")
      createUrl: $(this).data("create-url")
      deleteUrl: $(this).data("delete-url")

  $("#dialog").dialog
    autoOpen: false
    draggable: false
    modal: true
    title: "Choose an option"
    buttons: [
      {
        text: "Mark teeth for extraction (coming soon)"
        click: ->
          $(".ui-selected").addClass("extracted")
          $(this).dialog "close"
      }
      {
        text: "Mark teeth as missing (coming soon)"
        click: ->
          $(".ui-selected").addClass("missing")
          $(this).dialog "close"
      }
    ]
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
