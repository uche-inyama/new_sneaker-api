class Product < ApplicationRecord
  has_many :samples, dependent: :destroy
  has_many :orderables, dependent: :destroy
  has_many :carts, through: :orderables

  validates :stock, numericality: { greater_than_or_equal_to: 0 }

  LOW_STOCK_THRESHOLD = 10

  def self.stock_count?
    self.count
  end

   def low_stock?
    stock < 5
  end

  def check_sample_count?
    @samples_count = self.samples.count
		return true if @samples_count <= 3
  end

  def self.stock_list
    stock_array = []
    Product.all.each do |p|
      if p.stock >= 0
        stock_array << p.stock
      end
    end
    stock_array
  end 

  def restock(amount)
    update(stock: stock + amount)
  end

  def reduce_stock(amount)
    update(stock: stock - amount) if stock >= amount
  end

  def check_low_stock?
    self.count < LOW_STOCK_THRESHOLD
  end

  def notify_low_stock?
    where('stock < ?', LOW_STOCK_THRESHOLD).find_each do |product|
      NotifyAdminJob.perform_later(product)
    end
  end
end
