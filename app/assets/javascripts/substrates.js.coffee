$ ->
  $('.best_in_place').bind 'ajax:success', ->
    if $(this).data('place-success')
      substrate_id = $(this).data('place-success')
      $.ajax
        url: "/substrates/"+substrate_id+'.js'
        dataType: 'script'
