class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :search_name, null: true

      t.timestamps
    end
  end
end
