class Event < ApplicationRecord
  belongs_to :eld
  belongs_to :ad, optional: true
end
