$(document).on "ready page:load", ->
  $("[data-role='autotab-date']").each ->
    elem = $(this)
    target = $("[data-unit=#{elem.data('target')}]")
    previous = $("[data-unit=#{elem.data('previous')}]")
    elem.autotab_magic(
      target: target
      format: "numeric"
      previous: previous
    )

