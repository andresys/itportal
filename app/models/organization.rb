class Organization < ApplicationRecord
  has_many :assets
  has_one :department, dependent: :destroy
  has_many :titles, dependent: :destroy
end
