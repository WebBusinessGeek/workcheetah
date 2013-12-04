# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  if $('#new_invoice').length
    $('form#new_invoice').submit ->
      disable_buttons()
      true

    $('form.edit_invoice').submit ->
      disable_buttons()
      true

    $('#invoice_project_id').change ->
      id = $(this).val()
      window.location.href = 'new?project_id='+id unless id is ''
    bind_line_item_totals()

  if $('.edit_invoice').length
    $('#invoice_project_id').change ->
      id = $('.edit_invoice').data('id')
      project_id = $(this).val()
      window.location.href = '?project_id=' + project_id unless project_id is ''
    bind_line_item_totals()
    update_invoice_total()

disable_buttons = ->
  $('input[type=submit]').attr('disabled', true)
  $('input[type=submit]').attr('value', 'Submitting')

bind_line_item_totals = ->
    $('form').on 'change', 'input.hours', ->
      hours = $(this).val()
      rate = $(this).closest('ul').find('input.rate').val()
      total = get_total(hours, rate)
      target = $(this).closest('ul').find('input.total')
      target.val(total)
      update_invoice_total()
    $('form').on 'change', 'input.rate', ->
      rate = $(this).val()
      hours = $(this).closest('ul').find('input.hours').val()
      total = get_total(hours, rate)
      target = $(this).closest('ul').find('input.total')
      target.val(total)
      update_invoice_total()

get_total = (hours, rate) ->
  return (hours * rate).toFixed(2)

update_invoice_total = ->
  sum = 0
  $('input.total').each ->
    sum += Number $(this).val()
  $('#invoice_amount').val(sum.toFixed(2))