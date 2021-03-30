class CreateProductFamilies < ActiveRecord::Migration[6.1]
  def change
    create_table :product_families do |t|
      t.string :name

      t.timestamps
    end
  end
end
