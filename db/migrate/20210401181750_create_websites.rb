class CreateWebsites < ActiveRecord::Migration[6.1]
  def change
    create_table :websites do |t|
      t.string :url
      t.string :description
      t.references :bank, null: false, foreign_key: true

      t.timestamps
    end
  end
end
