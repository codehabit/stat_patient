$(document).on "click", "[data-action='star']", ->
  $this = $(this)
  $.ajax(
    url: $(this).data("url")
    method: "PUT"
  ).done((data)->
    $this.removeClass("glyphicon-star")
    $this.removeClass("glyphicon-star-empty")
    if data.starred
      whichOne = "glyphicon-star"
      order = 1
    else
      whichOne = "glyphicon-star-empty"
      order = 0
    $this.addClass(whichOne)
    $this.closest("td").attr("data-order", order)
  )

