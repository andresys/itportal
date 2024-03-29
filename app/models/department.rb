class Department < ApplicationRecord
  resourcify
  
  acts_as_nested_set
  belongs_to :organization, optional: true
  has_many :titles, dependent: :destroy
  
  validates :parent_id, presence: true, if: Proc.new { |d| d.organization_id.blank? }
  validates :name, presence: true
end
