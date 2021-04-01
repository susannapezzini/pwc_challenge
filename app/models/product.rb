# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  name        :string
#  search_name :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Product < ApplicationRecord
  has_many :subproducts
  has_many :fees

  has_many :prices, through: :fees
  has_many :banks, through: :subproducts
end
