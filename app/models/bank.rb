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

  has_many :websites
  accepts_nested_attributes_for :websites

  validates :name, uniqueness: true

  # The attribute 'name' needs to be unique and it is indexed (.where(name: ...))
  # will run faster
end
