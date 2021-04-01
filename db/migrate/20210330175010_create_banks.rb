class CreateBanks < ActiveRecord::Migration[6.1]
  def change
    create_table :banks do |t|
      t.string :name, null: false
      t.string :address
      t.string :country
      t.integer :bp_bank_id

      t.timestamps
    end

    add_index :banks, :bp_bank_id, unique: true
  end
end
