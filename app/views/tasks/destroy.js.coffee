$('#<%= dom_id(@task) %>')
  .fadeOut ->
    $(this).remove()