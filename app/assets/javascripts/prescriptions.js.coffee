$(document).on "click", "[data-role='assignment-remover']", (e)->
  $this = $(this)
  diagnosis_id= $this.data('diagnosis-id')
  drug_uuid = $this.data('drug-uuid')
  $this.fadeTo  "slow" , 0.5, ->
    url = "/decision_trees/remove_element.js?diagnosis_id=#{diagnosis_id}&drug_uuid=#{drug_uuid}"
    $.ajax
      url: url
      type: 'GET'
      success: (result) ->
        return true

$(document).on "click", "[data-role='decision-tree-builder']", (e)->
  category = $(this).data('category')
  drug_uuid = $(this).data('drug-uuid')
  url = "/decision_trees/build_element.js?category=#{category}&drug_uuid=#{drug_uuid}"
  $.ajax
    url: url
    type: 'GET'
    success: (result) ->
      return true

$(document).on "click", "[data-role='decision-tree-selector']", (e)->
  category = $(this).data('category')
  url = "/decision_trees/next_element.js?category=#{category}"
  $.ajax
    url: url
    type: 'GET'
    success: (result) ->
      return true

$(document).on "click", "[data-role='drug-selector']", (e)->
  category = $(this).data('category')
  uuid = $(this).data('drug-uuid')
  url = "/drugs/#{uuid}"
  $.ajax
    url: url
    type: "GET"
    success: (result) ->
      $('#prescription_order_dispense_amount').val(result.dispense_amount)
      $('#prescription_order_rx_instructions').val(result.sig)
      $('#prescription_order_patient_instructions').val(result.instructions_precautions)
      $('#prescription_order_drug_uuid').val(result.uuid)
      $('.leaves').hide()
      monographContent(result)

ready = ->

  # load the decision tree chooser on the rx form
  if (decision_tree_container = $("[data-role='decision-tree-selector-container']")).length
    drug_uuid = $(decision_tree_container).data('drug-uuid')
    url = "/decision_trees/next_element.js?category=top&drug_uuid=#{drug_uuid}"
    $.ajax
      url: url
      type: "GET"
      success: (result) ->


  # load the decision tree chooser on the edit drug page
  if (decision_tree_container = $("[data-role='decision-tree-container']")).length
    drug_uuid = $(decision_tree_container).data('drug-uuid')
    url = "/decision_trees/build_element.js?category=top&drug_uuid=#{drug_uuid}"
    $.ajax
      url: url
      type: "GET"
      success: (result) ->

  $('[data-type="select2"]').select2()

  $('[data-change="update-rx"]').change ->
    id = $(this).val()
    url = "/drugs/#{id}"
    $.ajax
      url: url
      type: "GET"
      success: (result) ->
        $('#prescription_order_dispense_amount').val(result.dispense_amount)
        $('#prescription_order_rx_instructions').val(result.rx_instructions)
        $('#prescription_order_patient_instructions').val(result.patient_instructions)
        monographContent(result)

  $('[data-change="update-pt"]').change ->
    id = $(this).val()
    url = "/patients/#{id}.json"
    $.ajax
      url: url
      type: "GET"
      success: (result) ->
        # $('.pt-info').html(result.age + ' yo ' + result.gender  )

  $('[data-role="rx-print-button"]').on "click", () ->
    window.location = $(this).data('target')

$(document).on('ready page:load', ready)

monographContent = (drug) ->
  $('.monograph #title').html("#{drug.name} #{drug.strength}")
  $('.monograph #interactions').html(drug.interactions)
  $('.monograph #adult_dosing').html(drug.adult_dosing)
  $('.monograph #peds_dosing').html(drug.peds_dosing)
  $('.monograph #contraindications').html(drug.contraindications)
  $('.monograph #pregnancy_lactating_precautions').html(drug.pregnancy_lactating_precautions)
  $('.monograph').show()



