class Bank < ApplicationRecord
  has_many :products
  has_many :pricings, through: :products
  has_many_attached :files
end
