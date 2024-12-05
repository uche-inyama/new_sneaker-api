class Product < ApplicationRecord
  has_many :samples, dependent: :destroy
  has_many :orderables, dependent: :destroy
  has_many :carts, through: :orderables

  validates :stock, numericality: { greater_than_or_equal_to: 0 }

  def check_sample_count?
    @samples_count = self.samples.count
		return true if @samples_count <= 3
  end

  def restock(amount)
    update(stock: stock + amount)
  end

  def reduce_stock
    update(stock: stock - amount) if stock >= amount
  end

  def low_stock?
    stock < 5
  end
end
