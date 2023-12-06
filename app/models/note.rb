class Note < ApplicationRecord
  belongs_to :noteble, polymorphic: true

  default_scope { order(date: :desc, created_at: :desc) }
end
