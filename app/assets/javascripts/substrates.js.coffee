$ ->
  $('.best_in_place').bind 'ajax:success', ->
    substrate_id = $(this).data('place-success')
    $.get "substrates/" + substrate_id, (data) ->
      a =1