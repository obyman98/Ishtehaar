class Vehicle < ApplicationRecord
  belongs_to :user
  attribute :status, default: -> { "pending" }
end
