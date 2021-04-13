class AddImgKeyToBanks < ActiveRecord::Migration[6.1]
  def change
    add_column :banks, :img_key, :string
  end
end
