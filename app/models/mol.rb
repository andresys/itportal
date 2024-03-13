class Mol < ApplicationRecord
  resourcify
  
  has_many :assets

  default_scope { order(name: :asc) }
end
