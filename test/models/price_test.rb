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
require "test_helper"

class PriceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
