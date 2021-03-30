class CreatePricings < ActiveRecord::Migration[6.1]
  def change
    create_table :pricings do |t|
      t.datetime :date_added, null: false
      t.string :file_url
      t.string :file_ext
      t.jsonb :metadata, default: {}
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
