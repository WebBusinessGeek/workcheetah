# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('#projects').sortable
    update: ->
      $.post($(this).data('update-url'), $(this).sortable('serialize'))

  $('#projects').disableSelection()

  $('ul#to_do, ul#doing, ul#done').sortable(
    connectWith: ".connectedSortable"
    placeholder: "ui-state-highlight"
    dropOnEmpty: true
    update: ->
      $.post($(this).data('update-url'), $(this).sortable('serialize'))
  ).disableSelection()

  # $('#doing').sortable
  #   connectWith: ['#to_do','#done']
  #   items: 'li'
  #   update: ->
  #     $.post($(this).data('update-url'), $(this).sortable('serialize'))

  # $('#done').sortable
  #   connectWith: ['#to_do','#doing']
  #   items: 'li'
  #   update: ->
  #     $.post($(this).data('update-url'), $(this).sortable('serialize'))

  # $('#to_do').disableSelection()