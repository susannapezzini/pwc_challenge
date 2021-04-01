# == Schema Information
#
# Table name: banks
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  address    :string
#  country    :string
#  bp_bank_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Bank < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :pricings, through: :products
  has_many :users
end
