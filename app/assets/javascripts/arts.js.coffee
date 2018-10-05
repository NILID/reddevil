$ ->
  $('#datetimepicker1 input').datepicker
    language: "ru"
    daysOfWeekDisabled: '0,2,3,4,6'
    startDate: new Date()

  $('body').delegate 'input[type=text].datepicker', 'focusin', ->
    $(this).datepicker
      language: "ru"
      isRTL: false
      showMonthAfterYear: false
      yearSuffix: ''
