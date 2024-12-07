class NotifyAdminJob < ApplicationJob
  queue_as :default

  def perform(*args)
    AdminMailer.low_stock_alert(product).deliver_now
  end
end
