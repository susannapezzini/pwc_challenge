class CreateBanks < ActiveRecord::Migration[6.1]
  def change
    create_table :banks do |t|
      t.string :name
      t.references :subscription, null: false, foreign_key: true

      t.timestamps
    end
  end
end
