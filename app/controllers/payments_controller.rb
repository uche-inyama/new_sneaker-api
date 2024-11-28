class PaymentsController < ApplicationController
  def new
  end

  def create_payment_intent
    @amount = params[:amount]
    @currency = params[:currency] || 'usd'
    @current_userId = params[:currentUserId]
    # debugger
    begin
      payment_intent = Stripe::PaymentIntent.create(
        amount: @amount.to_i*100,
        currency: @currency,
        payment_method_types: ['card'],
        metadata: { user_id: @current_userId }
      )
      render json: { client_secret: payment_intent['client_secret'] }
    rescue Stripe::StripeError => e
      render json: { error: e.message }, status: 400
    end
  end
end