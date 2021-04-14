class Group < ApplicationRecord
  has_many :subproducts, dependent: :nullify
    # belongs_to :product
  has_many :banks, through: :subproducts
end
