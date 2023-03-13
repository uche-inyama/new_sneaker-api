class CreateOrderables < ActiveRecord::Migration[7.0]
  def change
    create_table :orderables do |t|
      t.references :product, null: false, foreign_key: true
      t.references :cart, null: false, foreign_key: true
      t.integer :quantity
      t.string :image
      t.text :marketing_statement
      t.decimal :product_price
      t.decimal :product_discount

      t.timestamps
    end
  end
end
