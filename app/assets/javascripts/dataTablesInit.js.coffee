$(document).on "ready page:load", ->
  initDataTables()
  inbox = $("[data-role='inbox'] table")
  inbox_data = inbox.dataTable().fnGetData()

initDataTables = ->
  tableElement = $("[data-role='datatableized']")
  tableElement.dataTable
    "sPaginationType": "bootstrap"
    autoWidth: false
    stateSave: false
    order: []
  initTable("[data-role='inbox'] table")
  initTable("[data-role='sent'] table")
  initTable("[data-role='archived'] table")
  initLabsTables()

initLabsTables = () ->
  for tableType in ["active-orders", "closed-orders", "all-orders"]
    do ->
      initLabsTable(tableType)

initLabsTable = (tableType) ->
  tableElement = $("[data-role='#{tableType}'] table")
  tableElement.dataTable
    autoWidth: false
    stateSave: false

initTable = (selector) ->
  tableElement = $(selector)
  tableElement.dataTable
    autoWidth: false
    stateSave: false
    order: []
    bStateSave: true
    aoColumnDefs: [{ aDataSort: [ 0, 1 ], aTargets: [ 2 ]} ]
  tableElement.fnSetColumnVis( 0, false );
  tableElement.fnSetColumnVis( 1, false );

resetTable = (selector) ->
  $(selector).dataTable().fnDestroy()
  initTable(selector)

window.resetTable = resetTable
window.initTable = initTable
window.initDataTables = initDataTables
window.initLabsTables = initLabsTables
window.initLabsTable = initLabsTable

