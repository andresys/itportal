class Note < ApplicationRecord
  belongs_to :noteble, polymorphic: true

  default_scope { order(date: :asc, created_at: :asc) }
end
