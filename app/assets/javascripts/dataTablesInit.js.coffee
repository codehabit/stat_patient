$(document).on "ready page:load", ->
  responsiveHelper = undefined
  breakpointDefinition =
    tablet: 1024
    phone: 480

  tableElement = $("[data-role='datatableized']")
  tableElement.dataTable
    "sPaginationType": "bootstrap"
    autoWidth: false
    stateSave: false
    order: []
    preDrawCallback: ->
      responsiveHelper = new ResponsiveDatatablesHelper(tableElement, breakpointDefinition)  unless responsiveHelper
      return

    rowCallback: (nRow) ->
      responsiveHelper.createExpandIcon nRow
      return

    drawCallback: (oSettings) ->
      responsiveHelper.respond()
      return

