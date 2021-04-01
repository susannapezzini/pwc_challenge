# == Schema Information
#
# Table name: fees
#
#  id          :bigint           not null, primary key
#  product_id  :bigint           not null
#  name        :string
#  search_name :string
#  category    :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require "test_helper"

class FeeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
