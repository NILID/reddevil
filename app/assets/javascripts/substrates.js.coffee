$ ->
  $('.best_in_place').bind 'ajax:success', ->
    substrate_id = $(this).data('place-success')
    $.ajax "/substrates/"+substrate_id+"/remote_show"

  $('#substrates').sortable
    handle: '.handle'
    update: ->
      $.post($(this).data('update-url'), $(this).sortable('serialize'))
