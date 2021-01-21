$ ->
  $('body').on 'click', '#manufacture_group_without_contract', ->
    if this.checked
      $('#manufacture_group_contract').prop('disabled', true)
      $('#manufacture_group_contract').val('')
    else
      $('#manufacture_group_contract').prop('disabled', false)
