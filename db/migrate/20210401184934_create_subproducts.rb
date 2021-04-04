class CreateSubproducts < ActiveRecord::Migration[6.1]
  def change
    create_table :subproducts do |t|
      t.references :product, null: false, foreign_key: true
      t.references :bank, null: false, foreign_key: true
      t.string :name
      t.string :search_name, null: true

      t.timestamps
    end
  end
end
