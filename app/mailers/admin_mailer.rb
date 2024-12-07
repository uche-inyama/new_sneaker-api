class AdminMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def low_stock_alert(product)
    @product = product
    mail(to: current_admin.email, subject: 'Low Stock Alert: #{product.name}'
    )
  end
end
