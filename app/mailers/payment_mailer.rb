class PaymentMailer < ApplicationMailer
  default from: 'no-reply@yourapp.com'


  def payment_success(user, payment)
    @user = user
    @payment = payment
    mail(to: @user.email, subject: 'Payment Successful')
  end

  def payment_failure(user, payment)
    @user = user
    @payment = payment
    mail(to: @user.email, subject: 'Payment Failed')
  end
end
