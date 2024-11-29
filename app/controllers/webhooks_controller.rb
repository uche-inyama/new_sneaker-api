class WebhooksController < ApplicationController

  def stripe
    # Retrieve the event payload
    payload = request.body.read

    # Verify the signature (optional but recommended)
    endpoint_secret = Rails.application.credentials.dig(:stripe, :webhook_secret_development)
    event = nil
    begin
      sig_header = request.env['HTTP_STRIPE_SIGNATURE']
      event = Stripe::Webhook.construct_event(payload, sig_header, endpoint_secret)
    rescue JSON::ParserError => e
      render json: { error: 'Invalid payload' }, status: 400
      return
    rescue Stripe::SignatureVerificationError => e
      render json: { error: 'Invalid signature' }, status: 400
      return
    end

    # Handle the event
    case event['type']
    when 'payment_intent.succeeded'
      payment_intent = event['data']['object']
      # Process the successful payment (e.g., mark as paid in your database)
      handle_payment_success(payment_intent)
    when 'payment_intent.payment_failed'
      payment_intent = event['data']['object']
      # Handle failed payment
      handle_payment_failure(payment_intent)
    else
      # Unexpected event type
      Rails.logger.info("Unhandled event type: #{event['type']}")
    end

    render json: { message: 'Success' }, status: 200
  end

  private

  def handle_payment_success(payment_intent)
    # debugger
    payment = Payment.create!(
      stripe_payment_id: payment_intent['id'],
      amount: payment_intent['amount'],
      status: payment_intent['status'],
      user_id: extract_user_id_from_metadata(payment_intent)
    )
    user = User.find(payment.user_id)
    PaymentMailer.payment_success(user, payment).deliver_now
    # Rails.logger.info("Payment succeeded for ID: #{payment_intent['id']}")
    # Add logic to update your database, notify the user, etc.
  end

  def handle_payment_failure(payment_intent)
    user_id = extract_user_id_from_metadata(payment_intent)
    user = User.find(user_id)
    payment = Payment.new(
      stripe_payment_id: payment_intent['id'],
      amount: payment_intent['amount'],
      status: 'failed',
      user_id: user_id
    )
    PaymentMailer.payment_failure(user, payment).deliver_now
    # Rails.logger.info("Payment failed for ID: #{payment_intent['id']}")
    # Add logic to notify the user or retry the payment
  end

  def extract_user_id_from_metadata(payment_intent)
    payment_intent['metadata'] && payment_intent['metadata']['user_id']
  end
end
