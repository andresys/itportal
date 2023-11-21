class Uid < ApplicationRecord
  belongs_to :uidable, polymorphic: true
end
