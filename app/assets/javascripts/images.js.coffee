$(document).on "ready page:load", ->
  $("[data-role='viewpane']").zoom(
    url: $(this).data("target")
  )

