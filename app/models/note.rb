class Note < ApplicationRecord
  belongs_to :noteble, polymorphic: true

  has_many_attached :images, dependent: :destroy do |attachable|
    attachable.variant :thumb, :resize_to_fill => [200,200]
    attachable.variant :icon, :resize_to_fill => [34,34]
  end

  default_scope { order(date: :asc, created_at: :asc) }
end
