class Company < ApplicationRecord
  has_many :user
  validates_uniqueness_of :name, :email, :ntn
end
