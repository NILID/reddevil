# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('body').on 'click', '.membername', ->
    $(this).parentsUntil('.member').find('.hidden_info').slideToggle()
    $(this).parentsUntil('.member').find('.showinfo').toggleClass('icon-chevron-down icon-chevron-up')