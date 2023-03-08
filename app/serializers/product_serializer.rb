class ProductSerializer < ActiveModel::Serializer
  has_many :samples
  attributes :id, :name, :product_price, :product_discount, :marketing_statement
end
