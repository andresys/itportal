class Location < ApplicationRecord
  has_many :assets
  acts_as_nested_set

  has_many :rooms, dependent: :destroy
end
