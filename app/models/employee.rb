class Employee < ApplicationRecord

  has_many_attached :images do |attachable|
    attachable.variant :thumb, :resize_to_fill => [200,200]
    attachable.variant :icon, :resize_to_fill => [34,34]
  end

  belongs_to :department, optional: true
  belongs_to :title, optional: true

  default_scope { order(name: :asc) }
end
