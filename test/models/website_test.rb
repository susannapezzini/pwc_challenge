# == Schema Information
#
# Table name: websites
#
#  id         :bigint           not null, primary key
#  url        :string
#  bank_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require "test_helper"

class WebsiteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
