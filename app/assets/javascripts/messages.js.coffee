$(document).on "ready page:load", ->
  $("[data-role='select2']").select2(
    placeholder: $(this).attr("placeholder")
    width: "75%"
  )

Dropzone.options.dropzoneEnabled =
  autoProcessQueue: false
  uploadMultiple: false
  paramName: "image"
  init: ->
    myDropzone = this
    @element.querySelector("button[type=submit]").addEventListener "click", (e) ->
      e.preventDefault()
      e.stopPropagation()
      myDropzone.processQueue()
    @on "sending", ->
      console.log "Sending"
    @on "success", (files, response) ->
      cosole.log "Sent"
    @on "error", (files, response) ->
      console.log "Error@!"

