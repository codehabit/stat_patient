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

$(document).on('ready page:load', ready)

monographContent = (drug) ->
  $('.monograph #title').html(drug.name)
  $('.monograph #interactions').html(drug.interactions)
  $('.monograph #adult_dosing').html(drug.adult_dosing)
  $('.monograph #peds_dosing').html(drug.peds_dosing)
  $('.monograph #contraindications').html(drug.contraindications)
  $('.monograph #pregnancy_lactating_precautions').html(drug.pregnancy_lactating_precautions)

