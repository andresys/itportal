class Title < ApplicationRecord
  include RailsSortable::Model
  set_sortable :sort

  belongs_to :organization
  belongs_to :department

  validates :name, presence: true
  validates :organization, presence: true
  validates :department, presence: true
end
