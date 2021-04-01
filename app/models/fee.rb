# == Schema Information
#
# Table name: fees
#
#  id          :bigint           not null, primary key
#  product_id  :bigint           not null
#  name        :string
#  search_name :string
#  category    :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Fee < ApplicationRecord
  belongs_to :product
  has_many :prices

  has_many :subproducts, through: :prices
end
