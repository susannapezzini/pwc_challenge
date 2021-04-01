class AddBankIdOptionalToUsers < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :bank, null: true, foreign_key: true
  end
end
