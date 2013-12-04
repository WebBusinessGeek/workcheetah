$ ->
  $('form#new_estimate').submit ->
    disable_buttons()
    true

  $('form.edit_estimate').submit ->
    disable_buttons()
    true

disable_buttons = ->
  $('input[type=submit]').attr('disabled', true)
  $('input[type=submit]').attr('value', 'Submitting')