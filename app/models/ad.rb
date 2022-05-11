class Ad < ApplicationRecord
  belongs_to :user
  attribute :status, default: -> { "pending" }
  include ImageUploader::Attachment(:ad)
end
