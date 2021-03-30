class CreateBanks < ActiveRecord::Migration[6.1]
  def change
    create_table :banks do |t|
      t.string :name, null: false
      t.string :website, null: false
      t.string :address
      t.string :country

      t.timestamps
    end
  end
end
