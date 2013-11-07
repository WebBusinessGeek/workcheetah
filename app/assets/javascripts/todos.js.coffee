# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('#todo_list').on 'change','input[type=checkbox]', (e) ->
    todo_id = $(this).val()
    checked = $(this).is(':checked')
    payload = { checked: checked }
    $.post("/todos/" + todo_id + "/complete", payload).done (result) ->
      console.log result