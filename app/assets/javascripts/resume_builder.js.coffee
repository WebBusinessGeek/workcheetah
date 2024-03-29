jQuery ->
  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regex = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regex, time))
    event.preventDefault()

  $('form').on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('fieldset').hide()
    event.preventDefault()

  $('#resume_skill_ids').chosen
    theme: 'facebook'
    max_selected_options: 10
    allow_single_deselect: true
    no_results_text: 'No results matched'
    width: '300px'

  $('#search_skill_ids').chosen
    theme: 'facebook'

  $('input.date_picker').datepicker

  $('#job_skill_ids').chosen
    theme: 'facebook'
    max_selected_options: 10
    allow_single_deselect: true
    no_results_text: 'No results matched'
    width: '300px'

  $('#create_questionaire').on 'click', (e) ->
    e.preventDefault()
    $('#create_questionaire').hide()
    $('#questions').show()