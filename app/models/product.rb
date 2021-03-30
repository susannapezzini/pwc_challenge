class Product < ApplicationRecord
  store_accessor :pdf_sections

  belongs_to :product_family
  belongs_to :bank
  has_many :pricings
end
