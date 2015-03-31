$(document).on "ready page:load", ->
  initDataTables()

initDataTables = ->
  tableElement = $("[data-role='datatableized']")
  tableElement.dataTable
    "sPaginationType": "bootstrap"
    autoWidth: false
    stateSave: false
    order: []

  initTable("[data-role='inbox'] table")
  initTable("[data-role='sent'] table")

initTable = (selector) ->
  tableElement = $(selector)
  tableElement.dataTable
    autoWidth: false
    stateSave: false
    order: []
    bStateSave: true
    aoColumnDefs: [{ aDataSort: [ 0, 1 ], aTargets: [ 1 ]} ]
  tableElement.fnSetColumnVis( 0, false );

window.initDataTables = initDataTables
