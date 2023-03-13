class Product < ApplicationRecord
  has_many :samples, dependent: :destroy
  has_many :orderables, dependent: :destroy
  has_many :carts, through: :orderables
end
