require 'json'

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
  store_accessor :raw_data
  store_accessor :pages

  has_many :documents

  has_many :prices, through: :documents

  def pretty_raw_data
    JSON.pretty_generate(raw_data)
  end
end
