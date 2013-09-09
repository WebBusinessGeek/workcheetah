# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
    if $('#new_campaign').length or $('.edit_campaign').length
      toggle_target_selects $('#campaign_audience_target_ids option:selected').text()
      campaignForm = new CampaignForm
      campaignForm.updatePrice()
      $('#campaign_audience_target_ids').change ->
        toggle_target_selects $('#campaign_audience_target_ids option:selected').text()
        clear_all_selects()
        campaignForm.updateAll()
      $('#campaign_job_target_ids').change ->
        campaignForm.updateAll()
      $('#campaign_industry_target_ids').change ->
        campaignForm.updateAll()
      $('#campaign_employee_target_ids').change ->
        campaignForm.updateAll()
      $('#campaign_education_target_ids').change ->
        campaignForm.updateAll()
      $('#campaign_advertiser_target_ids').change ->
        campaignForm.updateAll()

    $('#campaign_audience_target_ids').chosen
        allow_single_deselect: true
        no_results_text: 'No results matched'
        width: '200px'
    $('#campaign_industry_target_ids').chosen
        allow_single_deselect: true
        no_results_text: 'No results matched'
        width: '200px'
    $('#campaign_job_target_ids').chosen
        allow_single_deselect: true
        no_results_text: 'No results matched'
        width: '200px'
    $('#campaign_employee_target_ids').chosen
        allow_single_deselect: true
        no_results_text: 'No results matched'
        width: '200px'
    $('#campaign_education_target_ids').chosen
        allow_single_deselect: true
        no_results_text: 'No results matched'
        width: '200px'
    $('#campaign_advertiser_target_ids').chosen
        allow_single_deselect: true
        no_results_text: 'No results matched'
        width: '200px'

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

clear_all_selects = ->
  $('#campaign_industry_target_ids').val([])
  $('#campaign_job_target_ids').val([])
  $('#campaign_employee_target_ids').val([])
  $('#campaign_education_target_ids').val([])
  $('#campaign_advertiser_target_ids').val([])

roundToTwo = (num) ->
    num.toFixed(2)

class CampaignForm
  constructor: ->
    @cpcPrice = @getPrice('cpc')
    @cpmPrice = @getPrice('cpm')

  getPrice: (type) ->
    base = 'base-' + type
    num = $('#audience_targets').data(base)
    audience_type = 'audience-' + $('#campaign_audience_target_ids option:selected').text()
    num = num + $('#audience_targets').data(audience_type) unless audience_type == 'audience-'
    if $('#industry_targets').is(':visible')
      if $('#campaign_industry_target_ids option:selected').text()
        num = num + ($('#campaign_industry_target_ids option:selected').size() * $('#industry_targets').data('industry'))
    if $('#job_targets').is(':visible')
      if $('#campaign_job_target_ids option:selected').text()
        num = num + ($('#campaign_job_target_ids option:selected').size() * $('#job_targets').data('job'))
    if $('#employee_targets').is(':visible')
      if $('#campaign_employee_target_ids option:selected').text()
        num = num + ($('#campaign_employee_target_ids option:selected').size() * $('#employee_targets').data('employee'))
    if $('#education_targets').is(':visible')
      if $('#campaign_education_target_ids option:selected').text()
        num = num + ($('#campaign_education_target_ids option:selected').size() * $('#education_targets').data('education'))
    if $('#advertiser_targets').is(':visible')
      if $('#campaign_advertiser_target_ids option:selected').text()
        num = num + ($('#campaign_advertiser_target_ids option:selected').size() * $('#advertiser_targets').data('advertiser'))
    num

  updateAll: ->
    @cpcPrice = @getPrice('cpc')
    @cpmPrice = @getPrice('cpm')
    @updatePrice()

  updatePrice: ->
    $('#cpm').html('$' + roundToTwo @cpcPrice)
    $('#cpc').html('$' + roundToTwo @cpmPrice)
