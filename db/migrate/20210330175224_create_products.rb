class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.jsonb :pdf_sections, default: {}, null: false
      t.references :product_family, null: false, foreign_key: true
      t.references :bank, null: false, foreign_key: true

      t.timestamps
    end
  end
end
