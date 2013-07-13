# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
    $('#campaign_start_date').datepicker
        dateFormat: 'yy-mm-dd'

    $('#campaign_end_date').datepicker
        dateFormat: 'yy-mm-dd'
    
    $('#new_ad_selector').bind 'click', (e) ->
        e.preventDefault()
        $('#new_ad_selector').hide()
        $('#text_ad_link').show()
        $('#image_ad_link').show()
