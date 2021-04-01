# == Schema Information
#
# Table name: subproducts
#
#  id          :bigint           not null, primary key
#  product_id  :bigint           not null
#  bank_id     :bigint           not null
#  name        :string
#  search_name :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require "test_helper"

class SubproductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
