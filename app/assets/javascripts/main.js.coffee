$ ->
  bsCustomFileInput.init()

  Chartkick.configure language: 'ru'

  soundManager.defaultOptions =
    loops: 1

  $('.tip').each (i) ->
    $(this).tooltipster
      content: $(this).find(".tip-text").html()
      theme: 'tooltipster-shadow'
      contentAsHTML: true
      delay: 10
      interactive: true

  $("a.fancybox").fancybox()

  $('.dropdown-toggle').dropdown()

  $('[data-toggle="tooltip"]').tooltip()

  $('.slide-block').hide()

  $('.slide-link').click ->
    $(this).next('ul').children('.slide-block').slideToggle()

  loopSound = (sound) ->
    sound.play onfinish: ->
      loopSound sound
      return
    return

  $('.repeat-link').click ->
    sound = $(this).parentsUntil('song').children('.sm2_link')
    sound_link = sound.attr('href')
    sound_id = sound.attr('id')
    sound_link = sound.attr('href')
    s = soundManager.createSound(id: sound_id, url: sound_link )
    if $(this).attr('data-repeat') == 'true'
      $(this).attr('data-repeat', 'false')
      $(this).toggleClass('active inactive')
      loopSound s
    else
      $(this).attr('data-repeat', 'true')
      $(this).toggleClass('active inactive')
      s.play loops: 0

  $('.readmore').readmore
    speed: 75
    moreLink: '<i class="icon icon-arrow-down">'
    lessLink: '<i class="icon icon-arrow-up">'
    collapsedHeight: 100

  $(":file").change ->
    fff = $(this).val()
    fff1 = fff.replace(/\.[^/.]+$/, "")
    $('form input.title_auto').val(fff1)

  $.extend $.fn.datepicker.defaults,
    format: 'yyyy-mm-dd'
    language: "ru"
    firstDate: 1

  $('#changecolor').colorpicker().on 'colorpickerChange colorpickerCreate', (e) ->
    $('body').css 'background', e.color

  $('#datetimepicker1 input').datepicker
    locale: "ru"
    daysOfWeekDisabled: '0,2,3,4,6'
    startDate: new Date()

  $('body').delegate 'input[type=text].datepicker', 'focusin', ->
    $(this).datepicker
      language: "ru"
      isRTL: false
      showMonthAfterYear: false
      yearSuffix: ''
      autoclose: true

  $('.dropdown-submenu > a').on 'click', (e) ->
    submenu = $(this)
    $('.dropdown-submenu .dropdown-menu').removeClass 'show'
    submenu.next('.dropdown-menu').addClass 'show'
    e.stopPropagation()
    return

  $('.dropdown').on 'hidden.bs.dropdown', ->
    # hide any open menus when parent closes
    $('.dropdown-menu.show').removeClass 'show'
    return

  jQuery('.best_in_place').best_in_place()