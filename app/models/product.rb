class Product < ApplicationRecord
  has_many :samples, dependent: :destroy
  has_many :orderables, dependent: :destroy
  has_many :carts, through: :orderables

  def check_sample_count?
    @samples_count = self.samples.count
		return true if @samples_count <= 3
  end
end
