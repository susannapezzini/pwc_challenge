# == Schema Information
#
# Table name: prices
#
#  id            :bigint           not null, primary key
#  fee_id        :bigint           not null
#  subproduct_id :bigint           not null
#  document_id   :bigint           not null
#  name          :string
#  amount        :float
#  category      :string
#  tax           :string
#  tax_amount    :float
#  tax_category  :string
#  status        :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Price < ApplicationRecord
  belongs_to :fee
  belongs_to :subproduct
  belongs_to :document

  has_one :bank, through: :subproduct
  has_one :product, through: :fee
end
