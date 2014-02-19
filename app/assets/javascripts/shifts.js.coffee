# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('#shift_calender').fullCalendar
    defaultView: 'agendaWeek'

    events:
      url: "/shifts/calendar.json"
      cache: false

    eventClick: (calEvent, jsEvent, view) ->
      $.get 'shifts/' + calEvent.id + '/edit.js'
      jsEvent.preventDefault()
