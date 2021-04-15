class AddFieldToRequests < ActiveRecord::Migration[6.1]
  def change
    add_column :requests, :bp_bank_id, :string
  end
end
