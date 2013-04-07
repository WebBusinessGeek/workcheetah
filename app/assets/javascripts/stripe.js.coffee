jQuery ->
  do_when_ready()
# $(window).bind('page:change', do_when_ready)

do_when_ready = ->
  # console.log("ready to fire")
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  new_payment_profile_form.setupForm()

new_payment_profile_form =
  setupForm: ->
    # console.log("form setup")
    $(document).on 'submit', '#new_payment_profile', ->
      # console.log("about to submit")
      $('input[type=submit]').attr('disabled', true)
      if $('#card_number').length
        # console.log("about to process card")
        new_payment_profile_form.processCard()
        false
      else
        true

  processCard: ->
    # console.log("processing card")
    card =
      number: $('#card_number').val()
      cvc: $('#card_code').val()
      expMonth: $('#card_month').val()
      expYear: $('#card_year').val()

    # console.log("getting stripe token")
    Stripe.createToken(card, new_payment_profile_form.handleStripeResponse)

  handleStripeResponse: (status, response) ->
    # console.log("handling response")
    if status == 200
      # console.log("status 200")
      $('#payment_profile_stripe_card_token').val(response.id)
      # console.log("stripe token set:" + response.id)
      $('#new_payment_profile')[0].submit()
    else
      # console.log("status not 2000")
      $('#stripe_error').text(response.error.message)
      # console.log("stripe errors set")
      $('input[type=submit]').attr('disabled', false)
