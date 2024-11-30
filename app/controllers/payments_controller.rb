class PaymentsController < ApplicationController
  before_action :authenticate_admin!
  def new
  end

  def index
    @payments_today = Payment.created_within_last_24_hours.order(created_at: :desc)
  end

  def create_payment_intent
    @amount = params[:amount]
    @currency = params[:currency] || 'usd'
    @current_userId = params[:currentUserId]
    begin
      payment_intent = Stripe::PaymentIntent.create(
        amount: @amount.to_i*100,
        currency: @currency,
        payment_method_types: ['card'],
        metadata: { user_id: @current_userId },
      )
      render json: { client_secret: payment_intent['client_secret'] }
    rescue Stripe::StripeError => e
      render json: { error: e.message }, status: 400
    end
  end
end