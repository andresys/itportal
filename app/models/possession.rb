class Possession < ApplicationRecord
  belongs_to :room
  belongs_to :employee
  belongs_to :possessionable, polymorphic: true
end
