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
require "test_helper"

class BankTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
