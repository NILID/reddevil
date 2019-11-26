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
        $('#substrate_block_a').show()
        $('#substrate_coating_type_b').selectpicker('val', 'нет')
        $('#substrate_wave_b').val('')
        $('#substrate_corner_b').val('')
        $('#substrate_block_b').hide()
      else if $(this).val() == 'b'
        $('#substrate_block_b').show()
        $('#substrate_coating_type').selectpicker('val', 'нет')
        $('#substrate_wave').val('')
        $('#substrate_corner').val('')
        $('#substrate_block_a').hide()
      else if $(this).val() == 'ab'
        $('#substrate_block_a').show()
        $('#substrate_block_b').show()
      else
        $('#substrate_block_a').hide()
        $('#substrate_block_b').hide()
        $('#substrate_coating_type_b').selectpicker('val', 'нет')
        $('#substrate_coating_type').selectpicker('val', 'нет')
        $('#substrate_wave_b').val('')
        $('#substrate_corner_b').val('')
        $('#substrate_wave').val('')
        $('#substrate_corner').val('')

      $('#substrate_coating_type').selectpicker('refresh')
      $('#substrate_coating_type_b').selectpicker('refresh')

  selectpicker_init()

  $('body').on 'onload change paste input keyup propertychange', 'select#substrate_sides', ->
    selectpicker_init(this)
