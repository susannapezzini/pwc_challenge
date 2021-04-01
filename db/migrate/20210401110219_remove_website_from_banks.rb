class RemoveWebsiteFromBanks < ActiveRecord::Migration[6.1]
  def change
    remove_column :banks, :website, :string
  end
end
