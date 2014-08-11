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
    else
      whichOne = "glyphicon-star-empty"
    $this.addClass(whichOne)
  )

