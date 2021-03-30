class Bank < ApplicationRecord
  belongs_to :subscription
  has_many :bank_products
  has_many :users, through: :subscriptions
end
