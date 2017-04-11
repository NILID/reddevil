$ ->
  $('#datetimepicker1 input').datepicker
    language: "ru"
    daysOfWeekDisabled: '0,2,3,4,6'
    startDate: new Date()
    format: "dd.mm.yyyy"

  $('body').delegate 'input[type=text].datepicker', 'focusin', ->
    $(this).datepicker
      language: "ru"
      format: "dd.mm.yyyy"
      isRTL: false
      showMonthAfterYear: false
      yearSuffix: ''
