assembleToothChartMarkingData = (status) ->
  $(".ui-selected").map ->
    {tooth_id: $(this).data("tooth-id"), status_code: status}

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
            data: {tooth_chart_markings_attributes: JSON.stringify(assembleToothChartMarkingData(3).get()), notes: $("#tooth_chart_observation").val()}
            success: (data) ->
              if data.new_case
                $("#case_messages_attributes_0_body").append("\n" + data.message_text)
              else
                $.remodal.lookup[$('[data-remodal-id=modal]').data('remodal')].close()
                location.reload()

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
            data: {tooth_chart_markings_attributes: JSON.stringify(assembleToothChartMarkingData(1).get()), notes: $("#tooth_chart_observation").val()}
            success: (data) ->
              if data.new_case
                $("#case_messages_attributes_0_body").append("\n" + data.message_text)
              else
                $.remodal.lookup[$('[data-remodal-id=modal]').data('remodal')].close()
                location.reload()
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
            data: {tooth_chart_markings_attributes: JSON.stringify(assembleToothChartMarkingData(2).get()), notes: $("#tooth_chart_observation").val()}
            success: (data) ->
              if data.new_case
                $("#case_messages_attributes_0_body").append("\n" + data.message_text)
              else
                $.remodal.lookup[$('[data-remodal-id=modal]').data('remodal')].close()
                location.reload()
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
