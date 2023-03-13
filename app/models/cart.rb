class Cart < ApplicationRecord
  has_many :orderables, dependent: :destroy
  has_many :products, through: :orderables
end
