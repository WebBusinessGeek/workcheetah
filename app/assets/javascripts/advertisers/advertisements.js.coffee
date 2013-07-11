# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
    $('a.trigger').click ->
        $('a.trigger').hide()
        $('#new_advertiser_sign_up').show()
        false
