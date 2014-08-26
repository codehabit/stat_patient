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
    target = $($(this).data("previous"))
    container = $(this).closest("[data-role*='-container']")
    container.hide()
    target.fadeIn()


  $(document).on "click", "[data-role='finisher']", (evt)->
    evt.preventDefault()
    $("[data-role='chooser-container']").fadeOut()
    $("[data-role='item-description-holder']").addClass("done")
    $("[data-role='restart']").parent().removeClass("hide")
    # $("[data-role='item-description-holder']").addClass("with-tab")

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
    next_step = $(this).data("next-step")
    stay_put = $(this).data("stay-put")
    container = $(this).closest("[data-role*='-container']")
    $("[data-role='vita-chart']").data("display", display)
    $("[data-role='vita-chart']").data("label", label)
    $("[data-role='vita-chart']").data("container", container)
    $("[data-role='vita-chart']").data("next-step", next_step)
    $("[data-role='vita-chart']").data("stay-put", stay_put)

  $(document).on "click", "[data-role='shade-picker']", (evt)->
    evt.preventDefault()
    value = $(this).data("value")
    label = $("[data-role='vita-chart']").data("label")
    container = $("[data-role='vita-chart']").data("container")
    next_step = $("[data-role='vita-chart']").data("next-step")
    stay_put = $("[data-role='vita-chart']").data("stay-put")
    if stay_put
      display = $($("[data-role='vita-chart']").data("display"))
      display.text(value)
      order_component_container = $("[data-component-type='shades']")
      if order_component_container.length == 0
        order_component_container = $("<span/>").attr("data-role", "order-component").attr("data-component-type", "shades").addClass("order-component")
        description_holder().append(order_component_container)
      order_component = $("<span/>").text(label + " " + value).addClass("order-component")
      order_component_container.append(order_component)
    else
      target = $(next_step)
      $(container).hide()
      $(target).fadeIn()
      order_component = $("<span/>").text(label + " " + value).attr("data-role", "order-component").addClass("order-component")
      description_holder().append(order_component)
    $("[data-role='vita-launcher']").popover("hide")

