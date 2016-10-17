# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('#datetimepicker1 input').datepicker
    language: "ru"
    daysOfWeekDisabled: '0,2,3,4,6'
    startDate: new Date()
    format: "dd.mm.yyyy"
