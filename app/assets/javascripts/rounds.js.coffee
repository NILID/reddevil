$ ->

  $('#winner-field').hide()

  if $("#forecast_team1goal").val() != '' && $("#forecast_team2goal").val() != ''
    basic =$("form input#forecast_ending_basic")
    basic_label =$("form .btn-group label.label-basic")
    overtime =$("form input#forecast_ending_overtime")
    overtime_label =$("form .btn-group label.label-overtime")
    penalty =$("form input#forecast_ending_penalty")
    penalty_label =$("form .btn-group label.label-penalty")

    if $("#forecast_team1goal").val() == $("#forecast_team2goal").val()
      $('#winner-field').show()

      basic_label.addClass('disabled')
      basic.attr('disabled', 'disabled')
      basic.attr('checked', false)

      overtime_label.addClass('disabled')
      overtime.attr('disabled', 'disabled')
      overtime.attr('checked', false)

      penalty_label.addClass('disabled')
      penalty.removeAttr('disabled')
      penalty.attr('checked', 'checked')
    else
      $('#winner-field').hide()

      if basic_label.is('.current')
        basic.attr('checked', 'checked')
      basic_label.removeClass('disabled')
      basic.removeAttr('disabled')

      if overtime_label.is('.current')
        overtime.attr('checked', 'checked')
      overtime_label.removeClass('disabled')
      overtime.removeAttr('disabled')

      penalty_label.addClass('disabled')
      penalty.attr('disabled', 'disabled')
      penalty.attr('checked', false)


  $('form input.number_field').change (event) ->
    $val1 = $("#forecast_team1goal").val()
    $val2 = $("#forecast_team2goal").val()

    basic =$("form input#forecast_ending_basic")
    basic_label =$("form .btn-group label.label-basic")
    overtime =$("form input#forecast_ending_overtime")
    overtime_label =$("form .btn-group label.label-overtime")
    penalty =$("form input#forecast_ending_penalty")
    penalty_label =$("form .btn-group label.label-penalty")

    if $val1 == $val2
      $('#winner-field').slideDown()

      basic_label.addClass('disabled')
      basic.attr('disabled', 'disabled')
      basic.attr('checked', false)

      overtime_label.addClass('disabled')
      overtime.attr('disabled', 'disabled')
      overtime.attr('checked', false)

      penalty.removeAttr('disabled')
      penalty_label.addClass('disabled')
      penalty.prop('checked', true)
    else
      $('#winner-field').slideUp()
      $("select#forecast_winner_id").val('')

      basic_label.removeClass('disabled')
      basic.removeAttr('disabled')
      if basic_label.is('.current') && penalty_label.not('.current') && overtime_label.not('.active') && basic_label.is('.acitve')
        basic.attr('checked', 'checked')

      overtime_label.removeClass('disabled')
      overtime.removeAttr('disabled')
      if overtime_label.is('.current') && penalty_label.not('.current') && basic_label.not('.active') && overtime_label.is('.acitve')
        overtime.attr('checked', 'checked')

      penalty.attr('disabled', 'disabled')
      penalty.attr('checked', false)

  $('#datetimeround input').datetimepicker
    language: "ru"
    format: "dd.MM.yyyy hh:mm"
