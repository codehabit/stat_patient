$(document).on "click", "[data-role='decision-tree-selector']", (e)->
  category = $(this).data('category')
  console.log "category is", category
  url = "/next_element.js?category=#{category}"
  $.ajax
    url: url
    type: 'GET'
    success: (result) ->
      console.log result

$(document).on "click", "[data-role='drug-selector']", (e)->
  category = $(this).data('category')
  id = $(this).data('drug-id')
  console.log "drug id is", id
  url = "/drugs/#{id}"
  $.ajax
    url: url
    type: "GET"
    success: (result) ->
      $('#prescription_order_dispense_amount').val(result.dispense_amount)
      $('#prescription_order_rx_instructions').val(result.sig)
      $('#prescription_order_patient_instructions').val(result.instructions_precautions)
      $('#prescription_order_drug_id').val(result.id)
      monographContent(result)

ready = ->
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
        $('.pt-info').html(result.age + ' yo ' + result.gender  )

  $('[data-role="rx-print-button"]').on "click", () ->
    window.location = $(this).data('target')

$(document).on('ready page:load', ready)

monographContent = (drug) ->
  $('.monograph #title').html(drug.name)
  $('.monograph #interactions').html(drug.interactions)
  $('.monograph #adult_dosing').html(drug.adult_dosing)
  $('.monograph #peds_dosing').html(drug.peds_dosing)
  $('.monograph #contraindications').html(drug.contraindications)
  $('.monograph #pregnancy_lactating_precautions').html(drug.pregnancy_lactating_precautions)


