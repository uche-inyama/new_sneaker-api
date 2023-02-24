class AddColumnsToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :name, :string
    add_column :products, :product_price, :decimal
    add_column :products, :product_discount, :decimal
    add_column :products, :marketing_statement, :text
  end
end
