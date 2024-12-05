class ReceiptMailer < ApplicationMailer
  def send_receipt(payment)
    @payment = payment
    mail(to: @payment.user.email, subject: "Your payment Receipt")
  end
end
