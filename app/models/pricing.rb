class Pricing < ApplicationRecord
  store_accessor :metadata

  belongs_to :product
end
