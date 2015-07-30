ready = ->
  $('body').scrollspy({ target: '#sidebar' })

$(document).ready(ready)
$(document).on('page:load', ready)