$ ->
  if('#new_estimate').length
    $('form#new_estimate').submit ->
      disable_buttons()
      true
    bind_line_item_totals()

  if('.edit_estimate').length
    $('form.edit_estimate').submit ->
      disable_buttons()
      true
    bind_line_item_totals()
    update_estimate_total()

disable_buttons = ->
  $('input[type=submit]').attr('disabled', true)
  $('input[type=submit]').attr('value', 'Submitting')

bind_line_item_totals = ->
    $('form').on 'change', 'input.hours', ->
      hours = $(this).val()
      rate = $(this).closest('fieldset').find('input.rate').val()
      total = get_total(hours, rate)
      target = $(this).closest('fieldset').find('input.total')
      target.val(total)
      update_estimate_total()
    $('form').on 'change', 'input.rate', ->
      rate = $(this).val()
      hours = $(this).closest('fieldset').find('input.hours').val()
      total = get_total(hours, rate)
      target = $(this).closest('fieldset').find('input.total')
      target.val(total)
      update_estimate_total()

get_total = (hours, rate) ->
  return (hours * rate).toFixed(2)

update_estimate_total = ->
  sum = 0
  $('input.total').each ->
    sum += Number $(this).val()
  $('#estimate_total').val(sum.toFixed(2))