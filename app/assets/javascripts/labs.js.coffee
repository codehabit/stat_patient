$(document).on "ready page:load", ->
  $(document).on "click", "[data-next]", (evt)->
    evt.preventDefault()
    target = $($(this).data("next"))
    container = $(this).closest("[data-role*='-container']")
    container.hide()
    target.fadeIn()

  $(document).on "click", "[data-previous]", (evt)->
    evt.preventDefault()
    target = $($(this).data("previous"))
    container = $(this).closest("[data-role*='-container']")
    container.hide()
    target.fadeIn()

  $(document).on "click", "[data-role='item-option']", (evt)->
    evt.preventDefault()
    description_holder = $("[data-role='item-description-holder']")
    description_holder.fadeIn()
    item_description = description_holder.text()
    option_text = $(this).text()
    description_holder.text(item_description + " " + option_text)

  $(document).on "change", "[data-role='item-option-selector']", (evt)->
    description_holder = $("[data-role='item-description-holder']")
    description_holder.fadeIn()
    item_description = description_holder.text()
    label = $(this).data("label")
    option_text = label + ": " + $(this).find("option:selected").text()
    description_holder.text(item_description + " " + option_text)

  $(document).on "click", "[data-role='finisher']", (evt)->
    evt.preventDefault()
    console.log("hi there")
    $("[data-role='chooser-container']").fadeOut()
    $("[data-role='restart']").parent().removeClass("hide")
    # $("[data-role='item-description-holder']").addClass("with-tab")
