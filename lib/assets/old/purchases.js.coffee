$(document).ready ->
  jQuery ->
    Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
    purchase.setupForm()

  purchase = 
    setupForm: ->
      $('#purchase').click ->
        $('#action_area').css('opacity', 0.4)
        $('#loading').css('display', 'inline-block')
        purchase.processCard()

    processCard: ->
      card = 
        number:     $('#card_number').val()
        cvc:        $('#card_code').val()
        exp_month:  $('#card_month').val()
        exp_year:   $('#card_year').val()
      Stripe.createToken(card, purchase.handleStripeResponse)

    handleStripeResponse: (status, response) ->
      if status == 200
        $('#purchase_stripe_card_token').val(response.id)
        purchase.sendToServer()
        
      else
        $('#stripe_error').text(response.error.message)
        $('#action_area').css('opacity', 1)
        $('#loading').css('display', 'none')
        $('input[type=submit]').attr('disabled', false)

    sendToServer: ->
      token = $('#purchase_stripe_card_token').val()
      product_id = $('#purchase_product_id').val()
      email = $('#purchase_email').val()
      beneficiary_id = $('#beneficiary_id').val()
      $.ajax
        async: false
        type: "POST"
        dataType: "json"
        url: "/purchases/?purchase[stripe_card_token]=" + token + "&purchase[product_id]=" + product_id + "&purchase[email]=" + email + "&purchase[beneficiary_id]=" + beneficiary_id
        success: (data) ->
          if data.response == "Your card was declined. Please check &uarr; and try again."
            $('#notice').html("#{data.response}")
            $('#notice').css("display", "block")
            $('#action_area').css('opacity', 1)
            $('#loading').css('display', 'none')
          else
            $('#new_purchase')[0].reset() # reset the form
            $('#action_area').html("<p>Thank you!</p><p>We emailed you a receipt.</p><p><a href='#{data.response}'>Download</a>.</p><p>Artwork by <a href='http://vinaysrinivasan.com/'>Vinay Srinivasan</a></p><p>Mastered by <a href='http://diovoce.net/'>Diovoce</a></p><p>Licensed by <a href='http://acappellarecords.com/'>A Cappella Records</a></p>")
            $('#action_area').css('opacity', 1)
            $('#loading').css('display', 'none')

  $('#show_purchase_form').click ->
    $('#action_area').css('display', 'block')
    $('.description').css('display', 'none')
    # $('#notice').css('display', 'block')

    $(this).css('display', 'none')