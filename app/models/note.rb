class Note < ApplicationRecord
  belongs_to :noteble, polymorphic: true
end
