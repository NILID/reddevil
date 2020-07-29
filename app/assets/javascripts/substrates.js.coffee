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
        $('#substrate_corner_b').val('')
        $('#substrate_block_b').hide()
      else if $(this).val() == 'b'
        $('#substrate_block_b').show()
        $('#substrate_coating_type').selectpicker('val', 'нет')
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
        $('#substrate_corner_b').val('')
        $('#substrate_corner').val('')

      $('#substrate_coating_type').selectpicker('refresh')
      $('#substrate_coating_type_b').selectpicker('refresh')

  selectpicker_init()

  $('.selectpicker-refresh').on 'cocoon:after-insert', ->
    $('.selectpicker').selectpicker('refresh')

  $('body').on 'onload change paste input keyup propertychange', 'select#substrate_sides', ->
    selectpicker_init(this)

  selectpicker_init_status = (select_tag = '.new_substrate input#substrate_instock', check = true) ->
    if check
      if $(select_tag).val() == '0'
        $('#substrate_status').selectpicker('val', 'missing')
      else
        $('#substrate_status').selectpicker('val', 'opened')
      $('#substrate_status').selectpicker('refresh')

  selectpicker_init_status('', false)

  $('body').on 'onload change paste input keyup propertychange', '.new_substrate input#substrate_instock', ->
    selectpicker_init_status(this)



  selectpicker_init_shape = (select_tag = 'select#substrate_shape') ->
    $('option:selected', select_tag).each ->
      if $(this).val() == 'circle'
        $('#shape_diameter').show()
        $('#substrate_width').val('')
        $('#substrate_height').val('')
        $('#shape_width').hide()
        $('#shape_height').hide()
      else
        $('#substrate_diameter').val('')
        $('#shape_diameter').hide()
        $('#shape_width').show()
        $('#shape_height').show()

  selectpicker_init_shape()

  $('body').on 'onload change paste input keyup propertychange', 'select#substrate_shape', ->
    selectpicker_init_shape(this)
