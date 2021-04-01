# == Schema Information
#
# Table name: requests
#
#  id         :bigint           not null, primary key
#  content    :jsonb
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Request < ApplicationRecord
  store_accessor :content

  has_many :documents

  has_many :prices, through: :documents
end
