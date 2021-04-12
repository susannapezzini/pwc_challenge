class AddGroupToSubproduct < ActiveRecord::Migration[6.1]
  def change
    add_reference :subproducts, :group, foreign_key: true
  end
end
