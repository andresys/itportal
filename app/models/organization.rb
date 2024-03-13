class Organization < ApplicationRecord
  resourcify
  
  has_many :assets
  has_one :department, dependent: :destroy
  has_many :titles, dependent: :destroy
  has_many :employees

  validates :name, presence: true

  default_scope do
    left_joins(:department)
      .order(Arel.sql("CASE WHEN organization_id IS NULL THEN 0 ELSE 1 END DESC, name ASC"))
      .group(:id, :organization_id)
  end
end
