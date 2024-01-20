class Location < ApplicationRecord
  has_many :assets
  has_many :rooms, dependent: :destroy

  validates :name, presence: true
end
