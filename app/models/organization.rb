class Organization < ApplicationRecord
  has_many :assets
  has_one :department, dependent: :destroy
  has_many :titles, dependent: :destroy
  has_many :employees

  default_scope { order(:name) }
end
