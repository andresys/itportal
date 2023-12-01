class Location < ApplicationRecord
  has_many :assets
  acts_as_nested_set
end
