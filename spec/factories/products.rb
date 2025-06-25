FactoryBot.define do
  factory :product do
    name { "Test Product" }
    product_price { 100.0 }
    product_discount { 10.0 }
    marketing_statement { "Buy now and save!" }
    stock { 20 }
  end
end