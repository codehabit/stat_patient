description_holder = ->
  return $("[data-role='item-description-holder']")

$(document).on "ready page:load", ->
  $(document).on "click", "[data-next]", (evt)->
    evt.preventDefault()
    target = $($(this).data("next"))
    container = $(this).closest("[data-role*='-container']")
    container.hide()
    target.fadeIn()

  $(document).on "click", "[role='item-option']", (evt)->
    evt.preventDefault()
    description_holder().fadeIn()
    option_text = $(this).text()
    order_component = $("<span/>").text(option_text).attr("data-role", "order-component").addClass("order-component")
    description_holder().append(order_component)

  $(document).on "click", "[data-previous]", (evt)->
    evt.preventDefault()
    order_components = description_holder().find("[data-role='order-component']")
    starting_size = order_components.length
    if starting_size >= 1
      order_components.last().remove()
    if description_holder().find("[data-role='order-component']").length == 0
      description_holder().fadeOut()
    target_selector = $(this).data("previous")
    current = $(this).data("current")
    if target_selector.indexOf("shade") > -1 || current.indexOf("shade") > -1
      $("[data-role*='shade-display']").text("")
      $("[data-role='vita-chart']").data("final", false)
    target = $(target_selector)
    container = $(this).closest("[data-role*='-container']")
    container.hide()
    target.fadeIn()


  $(document).on "click", "[data-role='finisher']", (evt)->
    evt.preventDefault()
    final_order = "Bridge/Crown"
    order_components = description_holder().find("[data-role='order-component']")
    $.each order_components, (index, value)->
      final_order = final_order + " | " + $(value).text()
    $("[data-role='final-order-input']").val(final_order)
    $("[data-role='chooser-container']").fadeOut()
    $("[data-role='item-description-holder']").addClass("done")
    $("[data-role='restart']").parent().removeClass("hide")

  $(document).on "click", "[data-role='restart']", (evt)->
    evt.preventDefault();
    description_holder().removeClass("done")
    $("[data-role='restart']").parent().addClass("hide")
    description_holder().find("[data-role='order-component']").last().remove()
    $("[data-role='chooser-container']").fadeIn()

  $("[data-role='vita-launcher']").popover(
    placement : 'right'
    title : 'Choose a shade'
    html: 'true'
    content : $("[data-role='vita-chart']").html()
  )

  $(document).on "click", "[data-role='vita-launcher']", (evt)->
    evt.preventDefault()
    display = $(this).data("display")
    label = $(this).data("label")
    final = $(this).data("final")
    $("[data-role='vita-chart']").data("display", display)
    $("[data-role='vita-chart']").data("label", label)
    $("[data-role='vita-chart']").data("final", final)

  $(document).on "click", "[data-final-picker]", (evt)->
    value = $(this).data("value")
    label = $("[data-role='vita-chart']").data("label")

  $(document).on "click", "[data-role='shade-picker']", (evt)->
    evt.preventDefault()
    value = $(this).data("value")
    label = $("[data-role='vita-chart']").data("label")
    container = $("[data-role='vita-chart']").data("container")
    display = $($("[data-role='vita-chart']").data("display"))
    final = $("[data-role='vita-chart']").data("final")
    if final
      $("[data-role*='shade-display']").text(value)
    else
      display.text(value)
    order_component_container = $("[data-component-type='shades']")
    if order_component_container.length == 0
      order_component_container = $("<span/>").attr("data-role", "order-component").attr("data-component-type", "shades").addClass("order-component")
      description_holder().append(order_component_container)
    order_component = $("<span/>").text(label + " " + value).addClass("order-component")
    order_component_container.append(order_component)
    $("[data-role='vita-launcher']").popover("hide")

