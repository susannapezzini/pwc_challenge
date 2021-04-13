class Group < ApplicationRecord
  has_many :subproducts
  belongs_to :product
end
