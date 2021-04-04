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

class Website < ApplicationRecord
  belongs_to :bank
  validates :url, length: {minimum: 5}
end
