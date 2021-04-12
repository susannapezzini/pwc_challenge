class AddColumnToFees < ActiveRecord::Migration[6.1]
  def change
    add_column :fees, :active, :boolean, default: true
  end
end
