# == Schema Information
#
# Table name: subproducts
#
#  id          :bigint           not null, primary key
#  product_id  :bigint           not null
#  bank_id     :bigint           not null
#  name        :string
#  search_name :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Subproduct < ApplicationRecord
  belongs_to :product
  belongs_to :bank

  has_many :prices
  has_many :fees, through: :prices

end
