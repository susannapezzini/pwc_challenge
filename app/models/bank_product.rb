class BankProduct < ApplicationRecord
  belongs_to :bank
  belongs_to :product
end
