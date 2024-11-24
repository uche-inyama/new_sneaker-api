class PaymentController < ApplicationController
  def new
  end

  def create
    @amount = params[:amount]

    begin
      payment_intent = Stripe::PaymentIntent.create(
        amount: @amount.to_i*100
        currency: 'usd',
        description: 'Payment for services',
        metadata: { user_id: current_user.id }
      )
      render json: { client_secret: payment_intent['client_secret'] }
    rescue Stripe::StripeError => e
      render json: { error: e.message }, status: 400
  end
end