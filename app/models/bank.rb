class Bank < ApplicationRecord
  has_many :products
  has_many :pricings, through: :products
  has_many :websites
  accepts_nested_attributes_for :websites
end
