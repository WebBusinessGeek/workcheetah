# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  # $('.task').on 'change','input[type=checkbox]', (e) ->
  #   project_id = $('.task').data('project-id')
  #   task_id = $(this).val()
  #   checked = $(this).is(':checked')
  #   payload = { checked: checked }
  #   $.post("/projects/" + project_id + "/tasks/" + task_id + "/complete", payload).done (result) ->
  #     console.log result