# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
    if $('#new_campaign').length or $('#edit_campaign').length
      toggle_target_selects $('#campaign_audience_target_ids option:selected').text()
      $('#campaign_audience_target_ids').change ->
        toggle_target_selects $('#campaign_audience_target_ids option:selected').text()

toggle_target_selects = (select) ->
  hide_all_select()
  switch select
    when 'employee'
      $('#job_targets').toggle()
      $('#employee_targets').toggle()
      $('#education_targets').toggle()
    when 'freelancer'
      $('#job_targets').toggle()
      $('#education_targets').toggle()
    when 'business'
      $('#industry_targets').toggle()
      $('#job_targets').toggle()
    when 'advertiser'
      $('#advertiser_targets').toggle()
    else
      return

hide_all_select = ->
  $('#industry_targets').hide()
  $('#job_targets').hide()
  $('#employee_targets').hide()
  $('#education_targets').hide()
  $('#advertiser_targets').hide()