class CreatePrices < ActiveRecord::Migration[6.1]
  def change
    create_table :prices do |t|
      t.references :fee, null: false, foreign_key: true
      t.references :subproduct, null: false, foreign_key: true
      t.references :document, null: false, foreign_key: true
      t.string :name
      t.float :amount
      t.string :category
      t.string :tax
      t.float :tax_amount
      t.string :tax_category
      t.string :status

      t.timestamps
    end
  end
end
