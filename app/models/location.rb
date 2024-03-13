class Location < ApplicationRecord
  resourcify
  
  has_many :assets
  has_many :rooms, dependent: :destroy

  validates :name, presence: true
end
