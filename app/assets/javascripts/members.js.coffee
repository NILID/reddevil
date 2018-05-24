$ ->
  $('body').on 'click', '.membername', ->
    $(this).parentsUntil('.member').find('.hidden_info').slideToggle()
    $(this).parentsUntil('.member').find('.showinfo').toggleClass('icon-chevron-down icon-chevron-up')

  $('#calendar').fullCalendar
    locale: "ru"
    #theme: true
    eventSources: [
      '/members.json'
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