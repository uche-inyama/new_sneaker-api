require 'csv'

class PaymentsController < ApplicationController
  before_action :authenticate_user!, only: [:create_payment_intent]
  respond_to :json, only: [:create_payment_intent]

  def new
  end

  def chart
    @payment_trends =  Payment.group_by_day(:created_at, time_zone: 'UTC').sum(:amount)
  end

  def index
    @payments = Payment.order(created_at: :desc).page(params[:page]).per(10)

    # if params[:status].nil? && params[:start_date].nil? && params[:end_date].nil?
    #   @payments = Payment.created_within_last_48_hours
    # end

    if params[:status].present?
      @payments = @payments.where(status: params[:status])
    end

    if params[:start_date].present? && params[:end_date].present?
      @payments = @payments.where(created_at: params[:start_date]..params[:end_date])
    end


    respond_to do |format|
      format.html 
      format.csv { send_data generate_csv(@payments), filename: "payments-#{Date.today}.csv"}
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

  def receipt
    payment = Payment.find(params[:id])
    @current_user = payment.user
    @payment = @current_user.payments.find(params[:id])
    render pdf: "receipt-#{@payment.id}", template: 'payments/receipt'
  end

  def send_receipt
    payment = Payment.find(params[:id])
    ReceiptMailer.send_receipt(payment).deliver_now
    redirect_to payments_path, notice: "Receipt sent successfully!"
  end

  def generate_csv(payments)
    CSV.generate(headers: true) do |csv|
      csv << ['Date', 'Amount', 'Status', 'Stripe ID']
      payments.each do |payment|
        csv << [
          payment.created_at.strftime('%Y-%m-%d'),
          payment.formatted_amount,
          payment.status.capitalize,
          payment.stripe_payment_id
        ]
      end
    end
  end

  private :generate_csv
end