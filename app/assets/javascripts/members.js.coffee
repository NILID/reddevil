$ ->
  $('body').on 'click', '.membername', ->
    $(this).parentsUntil('.member').find('.hidden_info').slideToggle()
    $(this).parentsUntil('.member').find('.showinfo').toggleClass('glyphicon-chevron-up glyphicon-chevron-down')

  $('#calendar').fullCalendar
    locale: "ru"
    #theme: true
    eventSources: [
      '/members.json'
      '/members/get_holidays.json'
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