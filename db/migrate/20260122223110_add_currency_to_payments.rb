class AddCurrencyToPayments < ActiveRecord::Migration[7.0]
  def change
    add_column :payments, :currency, :string, default: 'usd'
  end
end
