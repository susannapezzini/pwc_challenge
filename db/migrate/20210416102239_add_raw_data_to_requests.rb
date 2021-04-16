class AddRawDataToRequests < ActiveRecord::Migration[6.1]
  def change
    add_column :requests, :raw_data, :jsonb
  end
end
