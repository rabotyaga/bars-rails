$(document).on 'click', 'input[type=checkbox]', ->
  $.ajax({
    url: $(this).data('href'),
    type: 'PUT',
    dataType: 'json',
    data: $(this).attr("name") + "=" + $(this).is(":checked"),
    #success: (data, textStatus, jqXHR) ->
    #  $('body').append "<p class='text-success'>OK</p>"
    error: (jqXHR, textStatus, errorThrown) ->
      $('body').append "<p class='text-error'>AJAX Error: #{textStatus}</p>"
  })