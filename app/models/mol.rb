class Mol < ApplicationRecord
  has_many :assets

  default_scope { order(name: :asc) }
end
