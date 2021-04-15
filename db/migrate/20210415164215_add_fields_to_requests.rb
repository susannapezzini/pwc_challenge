class AddFieldsToRequests < ActiveRecord::Migration[6.1]
  def change
    add_column :requests, :bp_bank_pdf, :string
    add_column :requests, :product, :string
  end
end
