class CreateSamples < ActiveRecord::Migration[7.0]
  def change
    create_table :samples do |t|
      t.references :product, null: false, foreign_key: true
      t.text :image_data

      t.timestamps
    end
  end
end
