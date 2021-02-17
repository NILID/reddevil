$ ->
  $('body').on 'click', '.membername', ->
    member = $(this).parentsUntil('.member')
    member.find('.hidden_info').slideToggle()
    member.find('.icon-showicon').toggleClass('fa-chevron-up fa-chevron-down')

  $('body').on 'click', '#show_all_members', ->
    $('.hidden_info').slideToggle()
    $(this).toggleClass('fa-chevron-up fa-chevron-down')
    $('.icon-showicon').toggleClass('fa-chevron-up fa-chevron-down')

  $('#calendar').fullCalendar
    locale: "ru"
    themeSystem: 'bootstrap4'
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

  $('#user_theme').on 'change', ->
    $('link#custom_user_theme').attr('href', $(this).children('option:selected').data('url'))