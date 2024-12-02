class PaymentsController < ApplicationController
  before_action :authenticate_admin!
  def new
  end

  def index
    # I want the first query to return payments for the last 48hrs if status, start_date and end_date are empty?
    @payments = Payment.order(created_at: :desc)

    if params[:status].nil? && params[:start_date].nil? && params[:end_date].nil?
      @payments = Payment.created_within_last_48_hours
    end

    if params[:status].present?
      @payments = @payments.where(status: params[:status])
    end

    if params[:start_date].present? && params[:end_date].present?
      @payments = @payments.where(created_at: params[:start_date]..params[:end_date])
    end
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