$ ->
  if('#new_estimate').length
    $('form#send_estimate').on 'click', ->
      disableButtonAndSubmit()
      true

    $('form#save_estimate').on 'click', ->
      disableButtonAndSubmit()
      true
    bind_line_item_totals()

  if('.edit_estimate').length
    $('form#save_estimate').on 'click', ->
      disableButtonAndSubmit()
      true

    $('form.send_estimate').on 'click', ->
      disableButtonAndSubmit()
      true
    bind_line_item_totals()
    update_estimate_total()

disableButtonAndSubmit = ->
  input = $("<input type='hidden' />").attr("name", $(this)[0].name).attr("value", $(this)[0].value)
  $(this).closest('form').append(input)
  $(this).attr('disabled', 'disabled').html('Submitting...')
  $(this).closest('form').submit()

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