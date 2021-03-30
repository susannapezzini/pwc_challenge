class Product < ApplicationRecord
  belongs_to :product_family
  has_many :bank_products
end
