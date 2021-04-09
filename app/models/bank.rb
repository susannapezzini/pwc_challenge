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
  has_many :subproducts, dependent: :destroy
  has_many :products, through: :subproducts
  has_many :websites, dependent: :destroy
  has_many :pricings, through: :products
  has_many :users, dependent: :destroy
  has_many_attached :files
  has_one_attached :photo
  
  accepts_nested_attributes_for :websites

  validates :name, uniqueness: true
  validates :name, :address, :country, presence: true

  # The attribute 'name' needs to be unique and it is indexed (.where(name: ...))
  # will run faster
end
