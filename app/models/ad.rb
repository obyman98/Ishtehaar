class Ad < ApplicationRecord
  belongs_to :user
  has_many :events
  attribute :status, default: -> { "pending" }
  include ImageUploader::Attachment(:ad)
end
