class CreateRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :requests do |t|
      t.jsonb :content
      t.string :status

      t.timestamps
    end
  end
end
