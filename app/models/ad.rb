class Ad < ApplicationRecord
  belongs_to :user
  include ImageUploader::Attachment(:ad)
end
