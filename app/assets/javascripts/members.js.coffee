$ ->
  $('body').on 'click', '.membername', ->
    member = $(this).parentsUntil('.member')
    member.find('.hidden_info').slideToggle()
    member.find('.icon-showicon').toggleClass('glyphicon-chevron-up glyphicon-chevron-down')

  $('body').on 'click', '#show_all_members', ->
    $('.hidden_info').slideToggle()
    $(this).toggleClass('glyphicon-chevron-up glyphicon-chevron-down')
    $('.icon-showicon').toggleClass('glyphicon-chevron-up glyphicon-chevron-down')

  $('#calendar').fullCalendar
    locale: "ru"
    themeSystem: 'bootstrap3'
    eventSources: [
      '/members.json'
      '/vacations.json'
      '/events/list.json'
      '/relax.json'
    ]
    eventRender: (event, element) ->
      $(element).tooltip
        title: event.tooltip,container: "body"
    #eventMouseover: (calEvent, jsEvent, view) ->
    #   alert 'Event' + calEvent.title
    defaultView: 'month'
    schedulerLicenseKey: 'GPL-My-Project-Is-Open-Source'

  $('body').delegate '.input-daterange', 'focusin', ->
    $(this).datepicker
      language: "ru"
      isRTL: false
      showMonthAfterYear: false
      yearSuffix: ''
