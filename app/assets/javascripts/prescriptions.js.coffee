ready = ->
  
  $('[data-change="update-form"]').change ->
    alert 'changed'

$(document).ready(ready)
$(document).on('page:load', ready)
