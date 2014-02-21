jQuery ->
  if $('#resume_user_attributes_terms_of_service').is(':checked')
    $('#contact-details.hidden').css('visibility','visible').hide().fadeIn().removeClass('hidden')
    $('#rest.hidden').css('visibility', 'visible').hide().fadeIn().removeClass('hidden')

  $('#resume_user_attributes_terms_of_service').on 'change', ->
    if !$(this).is(':checked')
      $('#contact-details').css('visibility', 'hidden').hide(200).addClass('hidden')
      $('#rest').css('visibility', 'hidden').hide(200).addClass('hidden')
    else
      $('#contact-details.hidden').css('visibility','visible').hide().fadeIn().removeClass('hidden')

  $('#resume_status').on 'change', ->
    $('#rest.hidden').css('visibility', 'visible').hide().fadeIn().removeClass('hidden')

  $('#resume_resume_type').change ->
    if $(this).val().trim() is 'employee'
      toggle_employee()
    else if $(this).val().trim() is 'freelancer'
      toggle_freelancer()
    else
      toggle_business()

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
    width: '100%'

  $('#search_skill_ids').chosen
    theme: 'facebook'

  $('#job_skill_ids').chosen
    theme: 'facebook'
    max_selected_options: 10
    allow_single_deselect: true
    no_results_text: 'No results matched'
    width: '100%'

  $('#create_questionaire').on 'click', (e) ->
    e.preventDefault()
    $('#create_questionaire').hide()
    $('#questions').show()

toggle_employee = ->
  $('#rest').find('.skills').find('p.lead').text('Skills')
  $('#rest').find('.skills').find('.help-block').text('Select up to 10 skills. Skills can be easily searched for, added, or removed by simply clicking on the above field.')
  $('#rest').find('.references').find('p.lead').text('References')
  $('#rest').find('.reference').find('fieldset').find('.hidden').hide().css('visibility', 'hidden')
  $('#rest').show(200).css('visibility', 'visible')

toggle_freelancer = ->
  $('#rest.hidden').css('visibility', 'visible').hide().fadeIn().removeClass('hidden')
  $('#rest').find('.skills').find('p.lead').text('Services')
  $('#rest').find('.skills').find('.help-block').text('What services do you offer?')
  $('#rest').find('.references').find('p.lead').text('Referrals')
  $('#rest').find('.reference').find('fieldset').find('.hidden').hide().css('visibility', 'hidden')
  $('#rest').show(200).css('visibility', 'visible')

toggle_business = ->
  $('#rest.hidden').css('visibility', 'visible').hide().fadeIn().removeClass('hidden')
  $('#rest').find('.skills').find('p.lead').text('SERVICES')
  $('#rest').find('.skills').find('.help-block').text('What services does your company offer?')
  $('#rest').find('.references').find('p.lead').text('Referrals')
  $('#rest').find('.reference').find('fieldset').find('.hidden').show().css('visibility', 'visible')
  $('#rest').show(200).css('visibility', 'visible')
  $('.resume_status').hide()
  $('.experiences').hide()
  $('.educations').hide()