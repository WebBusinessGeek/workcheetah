# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  if $('#new_invoice').length
    $('#invoice_project_id').change ->
      id = $(this).val()
      window.location.href = 'new?project_id='+id unless id is ''
    bind_line_item_totals()
  if $('.edit_invoice').length
    bind_line_item_totals()

bind_line_item_totals = ->
    $('form').on 'change', 'input.hours', ->
      hours = $(this).val()
      rate = $(this).closest('ul').find('input.rate').val()
      total = get_total(hours, rate)
      target = $(this).closest('ul').find('li:last-child')
      target.html(total)
      target.data('total', total)
    $('form').on 'change', 'input.rate', ->
      rate = $(this).val()
      hours = $(this).closest('ul').find('input.hours').val()
      total = get_total(hours, rate)
      target = $(this).closest('ul').find('li:last-child')
      target.html(total)
      target.data('total', total)
      update_invoice_total()

get_total = (hours, rate) ->
  return (hours * rate).toFixed(2)

update_invoice_total = ->
  sum = 0
  $('li.total').each ->
    sum += Number $(this).data('total')
  $('#invoice_amount').val(sum.toFixed(2))