$(document).on "ready page:load", ->
  console.log("Yo here there hi")
  $("[data-role='viewpane']").zoom(
    url: $(this).data("target")
  )

