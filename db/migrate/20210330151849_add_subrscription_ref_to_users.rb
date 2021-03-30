class AddSubrscriptionRefToUsers < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :subscription, null: false, foreign_key: true
  end
end
