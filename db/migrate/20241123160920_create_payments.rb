class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.string :stripe_payment_id
      t.integer :amount
      t.string :status

      t.timestamps
    end
  end
end
