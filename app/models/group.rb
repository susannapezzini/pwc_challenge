class Group < ApplicationRecord
  has_many :subproducts
  # belongs_to :product
  has_many :banks, through: :subproducts
end
