@init_alert_autoclose = ->
  $('.alert').delay(5000).queue(
    ->
      $(this).remove()
  )
