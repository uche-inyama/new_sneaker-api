class Product < ApplicationRecord
  has_many :samples, dependent: :destroy
  # accepts_nested_attributes_for :samples, allow_destroy: true
end
