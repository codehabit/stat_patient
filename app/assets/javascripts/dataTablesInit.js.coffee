$(document).on "ready page:load", ->
  initDataTables()

initDataTables = ->
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

  tableElement = $("[data-role='inbox-datatableized']")
  tableElement.dataTable
    "sPaginationType": "bootstrap"
    autoWidth: false
    stateSave: false
    order: []
    bStateSave: true
    #aaSortingFixed: [[0,'desc']]
    aoColumnDefs: [{ aDataSort: [ 0, 1 ], aTargets: [ 1 ]} ]
    preDrawCallback: ->
      responsiveHelper = new ResponsiveDatatablesHelper(tableElement, breakpointDefinition)  unless responsiveHelper
      return

    rowCallback: (nRow) ->
      responsiveHelper.createExpandIcon nRow
      return

    drawCallback: (oSettings) ->
      responsiveHelper.respond()
      return


  tableElement.fnSetColumnVis( 0, false );

window.initDataTables = initDataTables
