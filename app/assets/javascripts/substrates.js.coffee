$ ->
  $('.best_in_place').bind 'ajax:success', ->
    if $(this).data('place-success')
      substrate_id = $(this).data('place-success')
      $.ajax
        url: "/substrates/"+substrate_id+'.js'
        dataType: 'script'

  selectpicker_init = (select_tag = 'select#substrate_sides') ->
    $('option:selected', select_tag).each ->
      if $(this).val() == 'a'
        $('#substrate_coating_type').selectpicker('show')
        $('#substrate_coating_type_b').selectpicker('val', 'нет')
        $('#substrate_coating_type_b').selectpicker('hide')
      else if $(this).val() == 'b'
        $('#substrate_coating_type_b').prop('disabled', false)
        $('#substrate_coating_type').selectpicker('val', 'нет')
        $('#substrate_coating_type').selectpicker('hide')
      else if $(this).val() == 'ab'
        $('#substrate_coating_type').selectpicker('show')
        $('#substrate_coating_type_b').selectpicker('show')
      else
        $('#substrate_coating_type_b').selectpicker('hide')
        $('#substrate_coating_type').selectpicker('hide')
        $('#substrate_coating_type_b').selectpicker('val', 'нет')
        $('#substrate_coating_type').selectpicker('val', 'нет')

      $('#substrate_coating_type').selectpicker('refresh')
      $('#substrate_coating_type_b').selectpicker('refresh')

  selectpicker_init()

  $('body').on 'onload change paste input keyup propertychange', 'select#substrate_sides', ->
    selectpicker_init(this)
