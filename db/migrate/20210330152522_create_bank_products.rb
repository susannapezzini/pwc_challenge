class CreateBankProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :bank_products do |t|
      t.references :bank, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
