$ ->
  $('.best_in_place').bind 'ajax:success', ->
    $.get(
      $($(this).data('place-success')).html($(this).data('place-state'))
      )