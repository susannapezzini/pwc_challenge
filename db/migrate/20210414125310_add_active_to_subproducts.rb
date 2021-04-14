class AddActiveToSubproducts < ActiveRecord::Migration[6.1]
  def change
    add_column :subproducts, :active, :boolean, default: true
  end
end
