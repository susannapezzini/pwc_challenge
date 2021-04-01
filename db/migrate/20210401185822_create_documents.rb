class CreateDocuments < ActiveRecord::Migration[6.1]
  def change
    create_table :documents do |t|
      t.references :bank, null: false, foreign_key: true
      t.references :request, null: false, foreign_key: true
      t.jsonb :meta
      t.datetime :data_added
      t.string :file_size
      t.string :file_url
      t.string :file_ext

      t.timestamps
    end
  end
end
