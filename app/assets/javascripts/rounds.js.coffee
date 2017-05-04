$ ->

  $('#winner-field').hide()

  if $("#forecast_team1goal").val() != '' && $("#forecast_team2goal").val() != ''
    if $("#forecast_team1goal").val() == $("#forecast_team2goal").val()
      $('#winner-field').show()

      basic =$("form input#forecast_ending_basic")
      basic_label =$("form .btn-group label[for='forecast_ending_basic']")
      basic_label.addClass('disabled')
      basic.attr('disabled', 'disabled')
      if basic.is(":checked")
        basic_label.addClass('active')

      overtime =$("form input#forecast_ending_overtime")
      overtime_label =$("form .btn-group label[for='forecast_ending_overtime']")
      overtime_label.addClass('disabled')
      overtime.attr('disabled', 'disabled')
      if overtime.is(":checked")
        overtime_label.addClass('active')

      penalty =$("form input#forecast_ending_penalty")
      penalty_label =$("form .btn-group label[for='forecast_ending_penalty']")
      penalty_label.removeClass('disabled')
      penalty.removeAttr('disabled')
      if penalty.is(":checked")
        penalty_label.addClass('active')
      else
        basic_label.addClass('active')

    else
      $('#winner-field').hide()

      basic =$("form input#forecast_ending_basic")
      basic_label =$("form .btn-group label[for='forecast_ending_basic']")

      basic_label.removeClass('disabled')
      basic.removeAttr('disabled')
      if $("form input#forecast_ending_basic").is(":checked")
        $("form .btn-group label[for='forecast_ending_basic']").addClass('active')


      overtime =$("form input#forecast_ending_overtime")
      overtime_label =$("form .btn-group label[for='forecast_ending_overtime']")
      overtime_label.removeClass('disabled')
      overtime.removeAttr('disabled')
      if overtime.is(":checked")
        overtime_label.addClass('active')

      penalty =$("form input#forecast_ending_penalty")
      penalty_label =$("form .btn-group label[for='forecast_ending_penalty']")
      penalty_label.addClass('disabled')
      penalty.attr('disabled', 'disabled')
      if penalty.is(":checked")
        penalty_label.addClass('active')
      else
        basic_label.addClass('active')



  $('form input.number_field').change (event) ->
    $val1 = $("#forecast_team1goal").val()
    $val2 = $("#forecast_team2goal").val()
    if $val1 == $val2
      $('#winner-field').slideDown()

      basic =$("form input#forecast_ending_basic")
      basic_label =$("form .btn-group label[for='forecast_ending_basic']")
      basic_label.addClass('disabled')
      basic.attr('disabled', 'disabled')
      if basic.is(":checked")
        basic_label.addClass('active')

      overtime =$("form input#forecast_ending_overtime")
      overtime_label =$("form .btn-group label[for='forecast_ending_overtime']")
      overtime_label.addClass('disabled')
      overtime.attr('disabled', 'disabled')
      if overtime.is(":checked")
        overtime_label.addClass('active')

      penalty =$("form input#forecast_ending_penalty")
      penalty_label =$("form .btn-group label[for='forecast_ending_penalty']")
      penalty_label.removeClass('disabled')
      penalty.removeAttr('disabled')
      if penalty.is(":checked")
        penalty_label.addClass('active')
      else
        basic_label.addClass('active')


    else
      $('#winner-field').slideUp()
      $("select#forecast_winner_id").val('')

      basic =$("form input#forecast_ending_basic")
      basic_label =$("form .btn-group label[for='forecast_ending_basic']")
      basic_label.removeClass('disabled')
      basic.removeAttr('disabled')
      if basic.is(":checked")
        basic_label.addClass('active')

      overtime =$("form input#forecast_ending_overtime")
      overtime_label =$("form .btn-group label[for='forecast_ending_overtime']")
      overtime_label.removeClass('disabled')
      overtime.removeAttr('disabled')
      if overtime.is(":checked")
        overtime_label.addClass('active')

      penalty =$("form input#forecast_ending_penalty")
      penalty_label =$("form .btn-group label[for='forecast_ending_penalty']")
      penalty_label.addClass('disabled')
      penalty.attr('disabled', 'disabled')
      if penalty.is(":checked")
        penalty_label.addClass('active')
      else
        basic_label.addClass('active')


  $('#datetimeround input').datetimepicker
    language: "ru"
    format: "dd.MM.yyyy hh:mm"
