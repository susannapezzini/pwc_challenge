class CreateSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :subscriptions do |t|
      t.integer :price
      t.integer :total_users
      t.date :expiring__date

      t.timestamps
    end
  end
end
