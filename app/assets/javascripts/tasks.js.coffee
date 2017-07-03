$ ->
  $('#progress_slider').slider
    value: $('#progress_slider').data('amount')
    min: 0
    max: 100
    step: 1
    slide: (event, ui) ->
      $('#progress_amount').val ui.value
      $('#progress_amount_show').text ui.value
      return
  $('#progress_amount').val $('#progress_slider').slider('value')