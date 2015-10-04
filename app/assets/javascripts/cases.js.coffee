assembleToothChartMarkingData = (status) ->
  $(".ui-selected").map ->
    {tooth_id: $(this).data("tooth-id"), status_code: status}

remodals = {}

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
    success: (data) ->
      previewElement = $(data.previewElement)
      attachment_id = $.parseJSON(data.xhr.response).created_id
      $.get "/attachments/#{attachment_id}", (image) ->
        $(".main-business").append(image)
        annotatable_image = $("[data-annotatable-id=#{attachment_id}] img")
        annotatable_image.on "load", ->
          annotatable_image.annotateImage
            editable: true
            useAjax: true
            getUrl: annotatable_image.data("get-url")
            createUrl: annotatable_image.data("create-url")
            deleteUrl: annotatable_image.data("delete-url")

      previewElement.on "click", ->
        console.log $("[data-annotatable-id=#{attachment_id}]")
        unless remodals[attachment_id]
          remodals[attachment_id] = $("[data-annotatable-id=#{attachment_id}]").remodal(hashTracking: false)
        remodals[attachment_id].open()
  )

  $("[data-role='zoom']").elevateZoom()

update_message = (data) ->
  current = $("#case_messages_attributes_0_body").val()
  if data.new_case
    $("#case_messages_attributes_0_body").val(current + "\n" + data.message_text)
  else
    $("#case_messages_attributes_0_body").val(current + "\n" + data.message_text)
    $.remodal.lookup[$('[data-remodal-id=modal]').data('remodal')].close()
    location.reload()

$(window).load ->
  $(".annotate").each ->
    $(this).annotateImage
      editable: true
      useAjax: true
      getUrl: $(this).data("get-url")
      createUrl: $(this).data("create-url")
      deleteUrl: $(this).data("delete-url")

  $("#tooth-chart-dialog").dialog
    autoOpen: false
    draggable: false
    modal: true
    title: "Choose an option"
    buttons: [
      {
        text: "Mark teeth for observation"
        click: ->
          $(".ui-selected").addClass("observation")
          $.ajax
            url: $("#tooth-chart").data("tooth-chart-path")
            type: "PUT"
            dataType: 'json'
            data: {tooth_chart_markings_attributes: JSON.stringify(assembleToothChartMarkingData(3).get()), notes: "Observation - #{$("#tooth_chart_observation").val()}"}
            success: (data) ->
              update_message(data)
          $(this).dialog "close"
      }
      {
        text: "Mark teeth for extraction"
        click: ->
          $(".ui-selected").addClass("extracted")
          $.ajax
            url: $("#tooth-chart").data("tooth-chart-path")
            type: "PUT"
            dataType: 'json'
            data: {tooth_chart_markings_attributes: JSON.stringify(assembleToothChartMarkingData(1).get()), notes: "Extraction - #{$("#tooth_chart_observation").val()}"}
            success: (data) ->
              update_message(data)
          $(this).dialog "close"
      }
      {
        text: "Mark teeth as missing"
        click: ->
          $(".ui-selected").addClass("missing")
          $.ajax
            url: $("#tooth-chart").data("tooth-chart-path")
            type: "PUT"
            dataType: 'json'
            data: {tooth_chart_markings_attributes: JSON.stringify(assembleToothChartMarkingData(2).get()), notes: "Missing - #{$("#tooth_chart_observation").val()}"}
            success: (data) ->
              update_message(data)
          $(this).dialog "close"
      }
    ]
    close: ->
      $(".temp-selected").removeClass("temp-selected ui-selected")
      $("#tooth_chart_observation").val("")

  if $("#tooth-chart").length > 0
    $.get $("#tooth-chart").data("tooth-chart-path"), (data) ->
      $.each data.tooth_chart_markings, (index, marking) ->
        $(".tooth-#{marking.tooth_id}").addClass("#{marking.status}")

  $("#tooth-chart").selectable
    cancel: ".extracted, .missing, .observation"
    selected: ->
      $(".extracted, .missing, .observation").removeClass("ui-selected")
      $(".ui-selected").addClass("temp-selected")
    stop: (e) ->
      $("#tooth-chart-dialog").dialog "option", "position",
        my: "center",
        at: "center",
        of: e
      $("#tooth-chart-dialog").dialog "open"

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

  $("[data-role='case-subject-typeahead']").autocomplete
    source: $("[data-role='case-subject-typeahead']").data("source")
