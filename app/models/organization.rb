class Organization < ApplicationRecord
  has_many :assets
  has_one :department, dependent: :destroy
  has_many :titles, dependent: :destroy
  has_many :employees

  # default_scope { left_joins(:department).order(:name) }
  default_scope { left_joins(:department).order(Arel.sql("organization_id ASC, name ASC")).group(:id, :organization_id) }
end
