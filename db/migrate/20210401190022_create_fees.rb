class CreateFees < ActiveRecord::Migration[6.1]
  def change
    create_table :fees do |t|
      t.references :product, null: false, foreign_key: true
      t.string :name
      t.string :search_name, null: true
      t.string :category

      t.timestamps
    end
  end
end
