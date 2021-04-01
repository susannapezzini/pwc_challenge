class Bank < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :pricings, through: :products
end
