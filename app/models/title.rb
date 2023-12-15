class Title < ApplicationRecord
  include RailsSortable::Model
  set_sortable :sort

  belongs_to :organization
  belongs_to :department
  has_one :employee

  validates :name, presence: true
  validates :organization, presence: true
  validates :department, presence: true

  default_scope { order(sort: :asc) }
end
