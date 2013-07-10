# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
    $('#advertisement_start_time').datepicker
        dateFormat: "yy-mm-dd"

    $('#advertisement_end_time').datepicker
        dateFormat: "yy-mm-dd"