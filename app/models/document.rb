# == Schema Information
#
# Table name: documents
#
#  id         :bigint           not null, primary key
#  bank_id    :bigint           not null
#  request_id :bigint           not null
#  meta       :jsonb
#  data_added :datetime
#  file_size  :string
#  file_url   :string
#  file_ext   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Document < ApplicationRecord
  belongs_to :bank
  belongs_to :request
  has_many :prices
end
